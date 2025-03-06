Return-Path: <linux-pwm+bounces-5115-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA87A55AEE
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Mar 2025 00:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778F9177790
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421027CB39;
	Thu,  6 Mar 2025 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9FAyKy8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E613D897;
	Thu,  6 Mar 2025 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304016; cv=none; b=IHrXtG/92mShk3HgyHAOaKcPuhCeU/NhNWXe2r3BJwM06v6ktGxfEMT5BiJZ68TZ4Fe66qiggYIx2egICdWGRtAJfnNqvoSTR6+0wH98VO8ajpbbq5XATtPHmMKxbyR9t+qXXb19stoxI7EQyAhiTNq489GiBkA/UBEIyeAoZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304016; c=relaxed/simple;
	bh=kCdbLq4MKXLwDRdTHw76PigGCWnhj7eKDSPYYqRZntY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgeOv4AnfZVU4ARZReYuu4S0G+z7luwKfTVezun+HDHHeGSH1vYNQ+wOES4U1HJuSlSaZAWUKCr3WCvhg8oRiLtkKg29DBEqENoyv5lJitvoN6+oLX6Vkq/MXYlJaHlDjh5CWLC/3If1jfZJosyLp67Iag6hHZApr5yYmQNxMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9FAyKy8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9EFC4CEE5;
	Thu,  6 Mar 2025 23:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741304015;
	bh=kCdbLq4MKXLwDRdTHw76PigGCWnhj7eKDSPYYqRZntY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9FAyKy8ohb1PeLj1EqmWd1zPedYvgckso3d73bNbfFKOExw3imTL95t3pTSiWZ9O
	 Gw6RsY01zRa5tsmxukA1MTzSs3B4bFP58eyeqKRoT1Y8sfLRhxQaUpM83sZhBuVEzQ
	 2QogVagOJ+ysSDFkXqeRtKLc7wArWKBU2z7tPbV+4AwIgXmhDl1neVPVO2YnyQg6ky
	 VlqnQXopv9kiQQR5XVzarpjkkx36xWsLAO5kDarYQ7Yc74AdWgX4s7LJBc11gSM8qi
	 areNCTtOUsOgSAKrRYxxHesMCrTswH27mP2gnO5+ad9yIOM7FU9ysSFIJoFOMsuazB
	 Ada39tJXebrRA==
Date: Fri, 7 Mar 2025 00:33:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
	Kamal Wadhwa <quic_kamalw@quicinc.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
Message-ID: <fnxx2tduww5m3ljs3g5po23ucr4qfytzipgspcf2udkusg7ys6@semr224oy56d>
References: <20250303-leds-qcom-lpg-compute-pwm-value-using-period-v1-1-833e729e3da2@linaro.org>
 <ylnkjxnukss7askv7ip5htrb4tyjzhpw7jim2se6rloleq5h6w@ngk7lbk26hxj>
 <dbfb17df-90e2-4a7c-9921-9dff5e9382f4@kernel.org>
 <ovnmhbzwwimil3opuv6e2ayyntlx7upxfkzm5qdfskx2x7hl7x@wmtul33ttow5>
 <bdca9e9f-7e0d-4ca7-8e8b-f27ea8bb3b54@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3wax27yl7jges3z"
Content-Disposition: inline
In-Reply-To: <bdca9e9f-7e0d-4ca7-8e8b-f27ea8bb3b54@kernel.org>


--h3wax27yl7jges3z
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] leds: rgb: leds-qcom-lpg: Compute PWM value based on
 period instead
MIME-Version: 1.0

Hello Krzysztof,

On Tue, Mar 04, 2025 at 05:30:40PM +0100, Krzysztof Kozlowski wrote:
> On 04/03/2025 17:03, Uwe Kleine-K=F6nig wrote:
> > On Tue, Mar 04, 2025 at 10:53:53AM +0100, Krzysztof Kozlowski wrote:
> >> On 04/03/2025 07:24, Uwe Kleine-K=C3=B6nig wrote:
> >>>> [...]
> >>>> ---
> >>>> base-commit: 0067a4b21c9ab441bbe6bf3635b3ddd21f6ca7c3
> >>>
> >>> My git repo doesn't know that commit. Given that you said your patch
> >>> bases on that other series, this isn't surprising. Please use a publi=
cly
> >>> available commit as base parameter, otherwise you (and I) don't benef=
it
> >>> from the armada of build bots because they just silently fail to test=
 in
> >>
> >> As you can easily see in the signature, this patchset was generated by
> >> b4 and such tag was added automatically. No point in stripping it even
> >> if it is not useful (life, happens).
> >=20
> > My request was not about stripping it, but making it useful. I don't
> > know the b4 patch sending side, but git send-email has the capability to
> > make it more useful in this scenario. I didn't check, but
> > `b4 --edit-deps` which Abel mentioned sounds about right.
> >=20
> > The relevant documentation for the git side is the paragraph "BASE TREE
> > INFORMATION" in git-format-patch(1).
>=20
> Useful how? The dependency is on the lists, so there is no base-commit
> you would know.

Have you tried to understand the part of the manpage I pointed out? It
seems to me "base-commit" has different semantics for us and only mine
is aligned to git's (and consequently b4's) meaning.
The correct base commit would have been
cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d.

> And regardless of edit-deps, that base-commit tag is standard from b4,
> so what do you expect from all submitters even if this was not RFC?

I don't understand this question. I expect from submitters to pick a
publicly known commit as base no matter if the series is an RFC or who's
standard this is.

> Always base on known commit?

Yes please. The manpage isn't explicit about that but the above
referenced commit has:

    The base tree info consists of the "base commit", which is a well-known
    commit that is part of the stable part of the project history everybody
    else works off of, and zero or more "prerequisite patches", which are
    well-known patches in flight that is not yet part of the "base commit"
    that need to be applied on top of "base commit" in topological order
    before the patches can be applied.

> But for most of the cases this is
> irrelevant. I can have intermediate commit between linux-next tip and my
> patch, thus base-commit will be bogus for you, but it does not matter
> for the patch - it's based on linux-next.

I agree, linux-next is the base. So the respective tip of linux-next is
the right thing to pass to git format-patch --base (independent of if
it's called directly or through b4). Ideally you also drop the
irrelevant intermediate patches to make the build bots test exactly the
changes you suggest with your series. I would expect that this is the
tree you actually tested, so it shouldn't be a big hurdle.

So summarizing we have: Iff you use --base with a non-public commit, it's
useless and irrelevant. I fully agree. Our conclusion is different
though. You accept it's useless (and even request from me that I do the
same), and I asked the submitter to use --base as intended to make the
resulting information usable.

Best regards
Uwe

--h3wax27yl7jges3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfKMMcACgkQj4D7WH0S
/k7Lygf/Wa8FyPopVUtLVV8RF+FamEmr7aP28fWYMpJ9idhxmdffTkrUmF7NiT4J
0pFxztHcSNJ1a9jZ9SGJ8EPovbz3fhwrvo9bvsmKRVWOaqC+YdnysBEzPbehBroo
YM7YnPZNLXy2Z/sgAh9a7w3A83gr+Uy86LfE8x6CQIuSM9byW50qgRZoDOIkmTuv
IzenAuIx7nt9Q4GM6toaaenlm8E/eze4pM8Yo6p9emHXPfqyGnm0UOqM9pc0uuoq
Lp5pjLpMjKOuaon2utLIGH10Yd2uM98v/ky3Iu0s9OrfjBMhmIJr/dFuWbHB+CwB
qul6dih0nSTcXdrI/m9B2txhPsxPJA==
=F+Te
-----END PGP SIGNATURE-----

--h3wax27yl7jges3z--

