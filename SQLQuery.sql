DECLARE @minNumberFairShows int
SET @minNumberFairShows =  (SELECT MIN(personNumberFairShows) FROM persons)

DECLARE @firstPersonID int
SET @firstPersonID = (SELECT TOP  1 personID FROM persons WHERE personNumberFairShows = @minNumberFairShows ORDER BY NEWID())

DECLARE @firstPersonPoint int
SET @firstPersonPoint = (SELECT personPoint FROM persons WHERE personID = @firstPersonID)

DECLARE @secondPersonID int
DECLARE @countMinNumberFairShows int
SET @countMinNumberFairShows = (SELECT COUNT(*) FROM persons WHERE personNumberFairShows = @minNumberFairShows)

IF (SELECT COUNT(*) FROM persons WHERE personPoint = @firstPersonPoint AND personNumberFairShows = @minNumberFairShows) > 1
BEGIN
	--Hvis to personer har samme point og samme antal shows skal de vises sammen
     SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint = @firstPersonPoint AND personNumberFairShows = @minNumberFairShows AND personID != @firstPersonID ORDER BY NewID())
END
ELSE
BEGIN
	IF @countMinNumberFairShows = 2
	BEGIN
		SET @secondPersonID = (SELECT personID FROM persons WHERE personID != @firstPersonID AND personNumberFairShows = @minNumberFairShows)
	END
	ELSE
	BEGIN
		DECLARE @upDifference int
		SET @upDifference = 0
		DECLARE @downDifference int
		SET @downDifference = 0

		DECLARE @countUp int
		DECLARE @countDown int
		DECLARE @upOrDown int

		IF	@countMinNumberFairShows > 2
		BEGIN
			SET @countUp = (SELECT COUNT(*) FROM persons WHERE personPoint > @firstPersonPoint AND personNumberFairShows = @minNumberFairShows)
			SET @countDown = (SELECT COUNT(*) FROM persons WHERE personPoint < @firstPersonPoint AND personNumberFairShows = @minNumberFairShows)
		
			IF @countUp > 0
			BEGIN
				SET @upDifference = ((SELECT TOP 1 personPoint FROM persons WHERE personPoint > @firstPersonPoint AND personNumberFairShows = @minNumberFairShows ORDER BY personPoint) - @firstPersonPoint)
			END
		
			IF @countDown > 0
			BEGIN
				SET @downDifference = (@firstPersonPoint - (SELECT TOP 1 personPoint FROM persons WHERE personPoint < @firstPersonPoint AND personNumberFairShows = @minNumberFairShows ORDER BY personPoint DESC))
			END

			IF @countUp != 0
			BEGIN
				IF @countDown != 0
				BEGIN
					IF @downDifference = @upDifference
					BEGIN
						SET @upOrDown = RAND() * 2

						IF @upOrDown = 1
						BEGIN
								SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint > @firstPersonPoint AND personNumberFairShows = @minNumberFairShows ORDER BY personPoint, NewID())
						END
						ELSE
						BEGIN
							SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint < @firstPersonPoint AND personNumberFairShows = @minNumberFairShows ORDER BY personPoint DESC, NewID())
						END
					END

					IF @downDifference < @upDifference
					BEGIN
						SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint < @firstPersonPoint AND personNumberFairShows = @minNumberFairShows ORDER BY personPoint DESC, NewID())
					END
					ELSE
					BEGIN
						SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint > @firstPersonPoint AND personNumberFairShows = @minNumberFairShows ORDER BY personPoint, NewID())
					END
				END
				ELSE
				BEGIN
					SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint > @firstPersonPoint AND personNumberFairShows = @minNumberFairShows ORDER BY personPoint, NewID())
				END
			END
			ELSE
			BEGIN
				SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint < @firstPersonPoint AND personNumberFairShows = @minNumberFairShows ORDER BY personPoint DESC, NewID())
			END
		END
		
		IF	@countMinNumberFairShows = 1
		BEGIN
			SET @countUp = (SELECT COUNT(*) FROM persons WHERE personPoint > @firstPersonPoint)
			SET @countDown = (SELECT COUNT(*) FROM persons WHERE personPoint < @firstPersonPoint)
		
			IF @countUp > 0
			BEGIN
				SET @upDifference = ((SELECT TOP 1 personPoint FROM persons WHERE personPoint > @firstPersonPoint ORDER BY personPoint) - @firstPersonPoint)
			END
		
			IF @countDown > 0
			BEGIN
				SET @downDifference = (@firstPersonPoint - (SELECT TOP 1 personPoint FROM persons WHERE personPoint < @firstPersonPoint ORDER BY personPoint DESC))
			END

			IF @countUp != 0
			BEGIN
				IF @countDown != 0
				BEGIN
					IF @downDifference = @upDifference
					BEGIN
						SET @upOrDown = RAND() * 2

						IF @upOrDown = 1
						BEGIN
								SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint > @firstPersonPoint ORDER BY personPoint, NewID())
						END
						ELSE
						BEGIN
							SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint < @firstPersonPoint ORDER BY personPoint DESC, NewID())
						END
					END

					IF @downDifference < @upDifference
					BEGIN
						SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint < @firstPersonPoint ORDER BY personPoint DESC, NewID())
					END
					ELSE
					BEGIN
						SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint > @firstPersonPoint ORDER BY personPoint, NewID())
					END
				END
				ELSE
				BEGIN
					SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint > @firstPersonPoint ORDER BY personPoint, NewID())
				END
			END
			ELSE
			BEGIN
				SET @secondPersonID = (SELECT TOP 1 personID FROM persons WHERE personPoint < @firstPersonPoint ORDER BY personPoint DESC, NewID())
			END
		END
	END
END

SELECT * FROM (SELECT * FROM persons WHERE personID = @firstPersonID UNION SELECT * FROM persons WHERE personID = @secondPersonID) personTable ORDER BY NewID()