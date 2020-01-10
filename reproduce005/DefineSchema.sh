#!/bin/sh

    curl -X POST localhost:8081/alter -d '
# Predicates with indices or special directives
director.film: [uid] @reverse @count .
actor.film: [uid] @count .
genre: [uid] @reverse @count .
initial_release_date: datetime @index(year) .
rating: [uid] @reverse .
country: [uid] @reverse .
loc: geo @index(geo) .
name: string @index(hash, term, trigram, fulltext) @lang .
starring: [uid] @count .
performance.character_note: string @lang .
tagline: string @lang .
cut.note: string @lang .
rated: [uid] @reverse .
email: string @index(exact) @upsert .

actor.dubbing_performances: [uid] .
apple_movietrailer_id: string .
art_direction_by: [uid] .
art_director.films_art_directed: [uid] .
casting_director.films_casting_directed: [uid] .
casting_director: [uid] .
character.portrayed_in_films: [uid] .
character.portrayed_in_films_dubbed: [uid] .
cinematographer.film: [uid] .
cinematography: [uid] .
collection.films_in_collection: [uid] .
collections: [uid] .
company.films: [uid] .
company_role_or_service.companies_performing_this_role_or_service: [uid] .
content_rating.country: uid .
content_rating.minimum_accompanied_age: int .
content_rating.minimum_unaccompanied_age: int .
content_rating.rating_system: uid .
content_rating_system.jurisdiction: [uid] .
content_rating_system.ratings: [uid] .
costume_design_by: [uid] .
costumer_designer.costume_design_for_film: [uid] .
crew_gig.crew_role: uid .
crew_gig.crewmember: uid .
crew_gig.film: [uid] .
crewmember.films_crewed: [uid] .
cut.film: [uid] .
cut.release_region: [uid] .
cut.runtime: float .
cut.type_of_cut: uid .
distribution_medium.films_distributed_in_this_medium: [uid] .
distributor.films_distributed: [uid] .
distributors: [uid] .
dubbing_performances: [uid] .
edited_by: [uid] .
editor.film: [uid] .
estimated_budget: [uid] .
executive_produced_by: [uid] .
fandango_id: string .
featured_locations: [uid] .
featured_song.featured_in_film: [uid] .
featured_song.performed_by: [uid] .
featured_song: [uid] .
festival.date_founded: dateTime .
festival.focus: uid .
festival.individual_festivals: [uid] .
festival.location: [uid] .
festival.sponsoring_organization: [uid] .
festival_event.festival: [uid] .
festival_event.films: [uid] .
festival_focus.festivals_with_this_focus: [uid] .
festival_sponsor.festivals_sponsored: [uid] .
festivals: [uid] .
filming: [uid] .
format.format: [uid] .
format: [uid] .
gross_revenue: [uid] .
job.films_with_this_crew_job: [uid] .
language: [uid] .
location.featured_in_films: [uid] .
locations: [uid] .
metacritic_id: string .
music: [uid] .
music_contributor.film: [uid] .
netflix_id: string .
other_companies: [uid] .
other_crew: [uid] .
performance.actor: uid .
performance.character: uid .
performance.film: [uid] .
performance.special_performance_type: [uid] .
person_or_entity_appearing_in_films: [uid] .
personal_appearance.film: [uid] .
personal_appearance.person: uid .
personal_appearance.type_of_appearance: uid .
personal_appearance_type.appearances: [uid] .
personal_appearances: [uid] .
post_production: [uid] .
pre_production: [uid] .
prequel: [uid] .
primary_language: [uid] .
produced_by: [uid] .
producer.film: [uid] .
producer.films_executive_produced: [uid] .
production_companies: [uid] .
production_company.films: [uid] .
production_design_by: [uid] .
production_designer.films_production_designed: [uid] .
regional_release_date.release_date: dateTime .
regional_release_date.release_region: uid .
release_date_s: [uid] .
rottentomatoes_id: string .
runtime: [uid] .
sequel: [uid] .
series.films_in_series: [uid] .
series: [uid] .
set_decoration_by: [uid] .
set_designer.sets_designed: [uid] .
song_films: [uid] .
song_performer.songs: [uid] .
songs: [uid] .
soundtrack: [uid] .
special_performance_type.performance_type: [uid] .
story_by: [uid] .
story_contributor.story_credits: [uid] .
subject.films: [uid] .
subjects: [uid] .
traileraddict_id: string .
trailers: [uid] .
writer_film: [uid] .
written_by: [uid] .

type Film {
    apple_movietrailer_id
    art_direction_by
    casting_director
    cinematography
    collections
    costume_design_by
    country
    distributors
    dubbing_performances
    edited_by
    executive_produced_by
    fandango_id
    featured_locations
    featured_song
    festivals
    format
    genre
    initial_release_date
    locations
    metacritic_id
    music
    name
    netflix_id
    personal_appearances
    prequel
    produced_by
    production_companies
    production_design_by
    rating
    release_date_s
    rottentomatoes_id
    sequel
    series
    set_decoration_by
    songs
    starring
    story_by
    subjects
    tagline
    traileraddict_id
    written_by

    # The objects for the following predicates are a part of the
    # Freebase data set, but not part of 21million.rdf.gz.
    post_production
    pre_production
    runtime
    other_crew
    other_companies
    primary_language
    soundtrack
    trailers
    gross_revenue
    estimated_budget
    filming
    language
}

type Actor {
    name
    actor.film
    actor.dubbing_performances
}

type ArtDirector {
    name
    art_director.films_art_directed
}

type CastingDirector {
    name
    casting_director.films_casting_directed
}

type Character {
    name
    character.portrayed_in_films
    character.portrayed_in_films_dubbed
}

type Cinematographer {
    name
    cinematographer.film
}

type Collection {
    name
    collection.films_in_collection
}

type Company {
    name
    company.films
}

type CompanyRoleOrService {
    name
    company_role_or_service.companies_performing_this_role_or_service
}

type CostumeDesigner {
    name
    costumer_designer.costume_design_for_film
}

type CrewGig {
    name
    crew_gig.crew_role
    crew_gig.crewmember
    crew_gig.film
}

type CrewMember {
    name
    crewmember.films_crewed
}

type Critic {
    name
}

type Cut {
    name
    cut.film
    cut.note
    cut.release_region
    cut.runtime
    cut.type_of_cut
}

type CutType {
    name
}

type Director {
    name
    director.film
}

type DistributionMedium {
    name
    distribution_medium.films_distributed_in_this_medium
}

type Distributor {
    name
    distributor.films_distributed
}

type Editor {
    name
    editor.film
}

type FeaturedSong {
    name
    featured_song.featured_in_film
    featured_song.performed_by
}

type Festival {
    name
    festival.date_founded
    festival.focus
    festival.individual_festivals
    festival.location
    festival.sponsoring_organization
}

type FestivalEvent {
    name
    festival_event.festival
    festival_event.films
}

type FestivalFocus {
    name
    festival_focus.festivals_with_this_focus
}

type FestivalSponsor {
    name
    festival_sponsor.festivals_sponsored
}

type FestivalSponsorship {
    name
    festival_sponsor.festivals_sponsored
}

type Format {
    name
    format.format
}

type Genre {
    name
}

type Location {
    name
    location.featured_in_films
}

type Job {
    name
    job.films_with_this_crew_job
}

type MusicContributor {
    name
    music_contributor.film
}

type Producer {
    name
    producer.film
    producer.films_executive_produced
}

type ProductionDesigner {
    name
    production_designer.films_production_designed
}

type Rating {
    name
    content_rating.country
    content_rating.minimum_accompanied_age
    content_rating.minimum_unaccompanied_age
    content_rating.rating_system
}

type RatingSystem {
    name
    content_rating_system.ratings
    content_rating_system.jurisdiction
}

type RegionalReleaseDate {
    name
    regional_release_date.release_date
    regional_release_date.release_region
}

type Series {
    name
    series.films_in_series
}

type SetDecorator {
    name
    set_designer.sets_designed
}

type Song {
    name
    song_films
}

type SongPerformer {
    name
    song_performer.songs
}

type StoryContributor {
    name
    story_contributor.story_credits
}

type Subject {
    name
    subject.films
}

type Writer {
    name
    writer_film
}

type Generic {
    name
}

type Performance {
    performance.actor
    performance.character
    performance.character_note
    performance.film
    performance.special_performance_type
}

type PersonalAppearance {
    name
    personal_appearance.film
    personal_appearance.person
    personal_appearance.type_of_appearance
    personal_appearance_type.appearances
}

type PersonalAppearanceType {
    name
}

type PersonOrEntityAppearingInFilm {
    name
    person_or_entity_appearing_in_films
    personal_appearance.film
}

type ProductionCompany {
    name
    production_company.films
}

type SpecialPerformanceType {
    name
    special_performance_type.performance_type
}

        '