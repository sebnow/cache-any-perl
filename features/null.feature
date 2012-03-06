Feature: Cache without an adapter
	In order to support caching in modules
	As a developer
	I want to be able to cache without setting an adapter

	Scenario: Cache with a Null adapter
		Given a Cache::Any object
		When the Null adapter is set
		And I cache "bar" using the key "foo"
		Then it should succeed
		And the key "foo" should not exist

	Scenario: Retrieve from cache with a Null adapter
		Given a Cache::Any object
		When the Null adapter is set
		And I get the key "foo" from the cache
		Then the value should be undefined

	Scenario: Remove from cache with a Null adapter
		Given a Cache::Any object
		When the Null adapter is set
		And I remove the key "foo" from the cache
		Then it should succeed
		And the key "foo" should not exist

	Scenario: Add to the cache with a Null adapter
		Given a Cache::Any object
		When the Null adapter is set
		And I add "bar" to the cache using the key "foo"
		Then it should succeed
		And the key "foo" should not exist

	Scenario: Replace a key in the cache with a Null adapter
		Given a Cache::Any object
		When the Null adapter is set
		And I replace "foo" with the value "bar" in the cache
		Then it should fail
		And the key "foo" should not exist

