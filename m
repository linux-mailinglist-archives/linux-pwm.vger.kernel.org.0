Return-Path: <linux-pwm+bounces-7298-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91093B546C6
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 11:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016D33B0976
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Sep 2025 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C8B283146;
	Fri, 12 Sep 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wYhnDlHT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A827A11B
	for <linux-pwm@vger.kernel.org>; Fri, 12 Sep 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668663; cv=none; b=EGo16/wjiBgD15vY7M9QBu22yBIYqzC+XmuahctXRALf9lGey+gNWtsvemr6vKEnAEUYGsnZFG1Y0e/tsM8YOyNW1bR1HR1kMUh3zJ26u79s2cEii3NKWs3W9wSEJqjxw/EcMshYSYyOVQi5I/+CeEqq+/1qtHJnrIHW6Icfnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668663; c=relaxed/simple;
	bh=dAzunc8kSouVdiputjBvwqN3B7KqxxrTw4svOekKNXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8dJ86WKKjqWQGO9MDVqJ8KXIfIctXTXfKf3/2PxN0Nhclko44NsR2c4sifw0iyIBsV5mzVGbnD1gvS4ogyOv16DiDEigz2SpmZsS39GRYSGQLgOerQdrINrPB9ZbiGEkAs9RryXmHks38CqQkqeNuJspVyLsYiRgwZrg50x36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wYhnDlHT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e75fb6b2e2so1798743f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 12 Sep 2025 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757668657; x=1758273457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAzunc8kSouVdiputjBvwqN3B7KqxxrTw4svOekKNXw=;
        b=wYhnDlHTY1w+ZYw4YkmL8AXSuyXLh8+jIGHwgcndjGDJMCSpSQerVwJqqbTyhi6OBU
         LKdqBxYxiC3Ots9VDVW+Bj/LWJeEn0tFNVluiIfjKvS6hNMZn3Uh3vp2PApeYfIQfkxT
         AHH+XE9857p2FvaMPk+FwzKDZf3YwEBmqISLyToIuwF+BKZFyc8yFIs1wVnqNH94Q+ug
         qm5SqOll6Z2XDFdUuf8/+3frYEcxsVL+0t2KSLjN+DZgZtOt50NAcKfvisdj7pvRiqtT
         4lb888cCmpMLR/K/OO3PK+tAvzgOtRmdbzM4FQeBwbw/anqrYLBiM0pQOfVB7YSJnVWG
         wGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757668657; x=1758273457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAzunc8kSouVdiputjBvwqN3B7KqxxrTw4svOekKNXw=;
        b=d2cIJmgM5jv/Pw2rQBExDeuwaMVeGTCweHEIWFBLepAP0fj/ifuxRoXz/4AK/19twh
         //TVHZ2oD8Gz1Q4//cQaOYGBgEuRnj0BwR4sFGJwltt0QYLNkPGtqgNvHxujuNXIZHFX
         PkYZ5CNhNNRUffwsY3nSlVsHih7YmriCfyHgyIknxvp3C7Ot8UItipYYyj+5adO+G13+
         q4Eu270/+F94D8u/1J884ZaBkMZtqjtCGQXoK71yzFZpILnsRH3CvFeRNwGZDZdMoGX/
         xOu02zWAUKAjSZWFPdzg6S4vHWIl5Jjf9FthNpzkBBca0rmVkNpCS8z3k76tvrIX96RK
         tO1w==
X-Gm-Message-State: AOJu0YxVW2Ya3r/6ecBHHIhjNT72lDRiL9baYQOZIhPe8zBwB2fBRY9c
	wk3vWSopbD5M2QCux1sn8i92aoOlQB2SZAo/Ju4oStMRo5gp1jzloJIds/u8wuUvcnMLlqR5vGh
	UG9pw
X-Gm-Gg: ASbGnct1JNftrHJoW6nG63G7coLWYZ/uOPjDHGqm0GCHijS+sP08/+OJNt6SwtqLK4+
	Y5HrqdQfOiUNpxEFUlzLbQOjG0Dw9qe6KAe+HwZMChRN8m/7lGXgEp+kYYks60KMo3/BVZ64O65
	6r215uZnPxYUT5Oycfv47GStwtrrPFoCkL+0M/2JI1XTqaHzxL/mGkKs3oFXZiBb01WePOX1DIS
	0OWAWMgolqDMzpNB3A3i3MjLaFdXwoCgvr3aFXT3reEZg7QIlsFRBzUV4RYN37AJtXFV0R/qyFJ
	XYRsGiLNuaQwdvG5Sqr/zYnDwy7+pocCq9v0gkgphgA7EIp8LYwT3PFQUv0ocJ4+OL9d7Tp6DvZ
	33E2uJ9MRy/1GwD7nbe81LlPY76X129EHDkDdSnB7fQgweoHQx4T4HcIKW1x/zJqrRXDUPoVIcP
	8=
X-Google-Smtp-Source: AGHT+IHz8XteP/olUc1tCERFdddboTegjLP3OGzEm/qDqaxY5Cl+sB58+JgEpdIdeKBlhVdrkmwEPg==
X-Received: by 2002:a05:6000:2885:b0:3e3:c5a8:a1be with SMTP id ffacd0b85a97d-3e76552eb61mr2033647f8f.0.1757668657158;
        Fri, 12 Sep 2025 02:17:37 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7607870cfsm5971148f8f.19.2025.09.12.02.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:17:36 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:17:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: "Philip, Avinash" <avinashphilip@ti.com>, 
	Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: Re: [PATCH 0/4] pwm: tiehrpwm: various fixes
Message-ID: <fyvzcj6tmw6lq356roxsilt3scmwauf7hmznhexo7gdf7m7l3g@7afjz4vzcyxe>
References: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26kg4jimhch4pun5"
Content-Disposition: inline
In-Reply-To: <cover.1754927682.git.u.kleine-koenig@baylibre.com>


--26kg4jimhch4pun5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4] pwm: tiehrpwm: various fixes
MIME-Version: 1.0

Hello,

On Mon, Aug 11, 2025 at 06:00:58PM +0200, Uwe Kleine-K=F6nig wrote:
> I setup the PWM device on a beaglebone black with the intention to
> convert this driver to the waveform API. Before getting to that though,
> I found various issues that are addressed here. The problems fixed are
> all quite old, they all exist since 2012, so I think there is no urge to
> get them in and I tend to let them stay in next for a while.

I applied this series to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes
=2E But the patches in that branch are not that urgent, mostly fixing
issues that are already quite old, only affect debugging or bits that
are not relevant yet. So (as of today) I plan to send it as part of the
PR targeted for 6.18-rc1.

Best regards
Uwe

--26kg4jimhch4pun5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjD5SoACgkQj4D7WH0S
/k7YmAf/frjWCgs2dkTZyf7TQVYgxbsvBVk5gjuvmukOPByMv9BHH+cNj4XJx3KR
Y83ODFh7Nsz7Qv6QHHDJQ/kgQKpV3Kqp2h4lKbUY2kwWHhu0s2VxUMruGBL0W8mj
JH/A6v2uRp3jRhl6GnMDKegOgqjOASCQhYR06uC7KBSxpqFUfGEBEtNBJkE0UOpQ
wqSDU6AHKOgOsFkp4SxhVLLJ/frbM+bMDTUGmLl5esqYyWvkKx/zSLx0hW7sxdlD
g4hXu89UOd3a+2r3fPEVURDdEcgmwMVBH3zY67Nv2WzBm9N/2A04W/xKzwgSbMrY
de4/WT6oPNRLy32nmzSoo4HHStkcXw==
=d0qM
-----END PGP SIGNATURE-----

--26kg4jimhch4pun5--

