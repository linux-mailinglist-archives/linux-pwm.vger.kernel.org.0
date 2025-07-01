Return-Path: <linux-pwm+bounces-6618-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3DAEF059
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 10:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E7B1BC2FCF
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D6426561E;
	Tue,  1 Jul 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IuwBUGBo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7B1DED77
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356865; cv=none; b=t4Jx58E0iSTRSKa6Sag0HvxplcC/tfSIVYBbasWN48Y1jZUKLSVoXs0Xd/owhdswgmGqC+lUCQHmbaZlogtkMbvnqFyfofXnikL6/yjm/TLbh1i0P5ni5dOX5sepU70+kjWsvCgzelv8ydDddu7ZOqjfjpMEv2dxBA9K4wncUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356865; c=relaxed/simple;
	bh=mGcOMYTXcHolXofkzg4axIdhZFPgH1PGHQ+D0OUph78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxmrnLaQ5SBhQPP+jGbLUByPcCNb4axslIKbz4QzsDW7QfVL9Pd0Q8WXGHfvI1mUpsLMR+2iQ5+ZjxrjeICXovjkTm5Ifx1KCNbEg+G1fzdhW85ispEwnl/qEMcC0xcLLRvnw4C3OhS92OMr7ZiP+pNPIm9KeVsroOHYOpRMLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IuwBUGBo; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso10025842a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 01 Jul 2025 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751356860; x=1751961660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGcOMYTXcHolXofkzg4axIdhZFPgH1PGHQ+D0OUph78=;
        b=IuwBUGBoFW+TimBmjVVW72/8um34gppSaPEZRfkm5Fawd3f7tHQBOg5btSwQaLajMM
         tBa66+IC6ms1zYoZMfiUFLcGFGiEjoME88jLNExGBGSaE9qUA+BT0EaMeqpOotXe2JHo
         D79PZWDWc59BB8ELjvvwe0NMejyRL3O1d5v87HzEOLiwa1+fQjDfW853yvRXI5z5VONO
         yXF4D7XB46Hu4sCMuLFhSTWG+9BWi2slku9zzWApFQqg4I/wVM/Q6aIaWL96kQH+7T5i
         95sJ2j7i+NCbNjmTuQCpCj6uMsGl90j4pNbCsoHDUQ7czL5QopHtfX7FnVXnHc/r51zU
         hZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356860; x=1751961660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGcOMYTXcHolXofkzg4axIdhZFPgH1PGHQ+D0OUph78=;
        b=QW3SdUqanj2BTO0T/fan/ZWikKM77jK8pDWPJN/wUHICRoO2HPr6Lp89m/BXRgRbNi
         qTKlKMQeN+2MxP96eGnluUlbs2YvqBxB0x+24I6aKKOogDYjfkEhgGlezGimoBPUKfu7
         pRk/OR9UARw6nYIdyBrvdkqtspsK+f92uSk3GmPWGDa3/jXwtX6PI9BYtf1wRQ0Di3b8
         0lrcodg7dvr9p03QLANJUc1vtWh4c060EvaF69HNENj8s7qJXgrGYbFYXdIVIsRlDsyS
         SNSO/ehQ4BAopChbhjGgMUMwop1Qjlorh9/ELrpkqu4A20FrBlcShAagd1HcNBsdEEXW
         xiSQ==
X-Gm-Message-State: AOJu0YzPYMqF4DDtel/YOtKZ5Gw91Kea88DiCpK/zL60KbWoM+EOfQVF
	vSJYtWby4LB25OfXNns4AcvBrJdpZIdSf8XkNXB5Qz+Z4E7EwAWNt1p2sw3CpecJIJkG7McUoxS
	/LqLY
X-Gm-Gg: ASbGnctjgESOtnOluMVlVNIrDsQ2Gw7gKVhxhqE9HoUwhlxZr3QXuLdabLn9F/2rjfG
	pjJPGPIfpFTgEUlMzmgtW9xuaI/KChkwm1kkkv/hMq5UksQyN7HtdckgSQTdwuRqrIRFZHsgUaW
	HWIR7B5xPjHkOqqS5wcvn30KKWbY3NB5on7EKpjziRy6LBmFEnoSjUmS8yp0C9pUITntKiN0Le7
	dguJtkbG/aPCCC97lhB7jnWlWxQ5SEnvfZp1R/Ip2FxUCs+84nr3Tud09hEvFuBHyhWIPsST/5X
	1GsYPZ9anK8QYuVV02K0wHmrUFR76IOnUTbQMrjMAoS3zx08kRA6E32rRL/5VZgTg8C11YRujCs
	QiFni/3RdnRZhbEswMvjVHFrjqT1e
X-Google-Smtp-Source: AGHT+IHoseuQMT7L82E1RTcFaZzcxBl/sncW7x0w5KT8BrdeT13LEqZ3NuYBc4NWEr1hlzzeJ6jwYA==
X-Received: by 2002:a05:6402:35d3:b0:608:a7a0:48 with SMTP id 4fb4d7f45d1cf-60c88e7a5d0mr14169020a12.28.1751356856720;
        Tue, 01 Jul 2025 01:00:56 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c8319aef5sm7256977a12.48.2025.07.01.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:00:55 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:00:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: pwm: Adapt Locking paragraph to reality
Message-ID: <askcct3mnuve3ivaghfkmxdzrni2bwoy77ytsfsi7mfketnaoq@cxbiuzacykhs>
References: <20250624100500.1429163-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m3ixujeyfvwblqu5"
Content-Disposition: inline
In-Reply-To: <20250624100500.1429163-2-u.kleine-koenig@baylibre.com>


--m3ixujeyfvwblqu5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] docs: pwm: Adapt Locking paragraph to reality
MIME-Version: 1.0

Hello,

On Tue, Jun 24, 2025 at 12:05:00PM +0200, Uwe Kleine-K=F6nig wrote:
> We have the distinction between pwm_apply_atomic() and
> pwm_apply_might_sleep() since commit c748a6d77c06 (pwm: Rename
> pwm_apply_state() to pwm_apply_might_sleep()) contained in v6.8-rc1.
>=20
> Locking in the core was introduced in commit 1cc2e1faafb3 ("pwm: Add
> more locking", contained in v6.13-rc1) to serialize per-chip callbacks
> and device removal.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
> I guess there are no objections and so will apply this patch to my pwm
> tree in a week or so if there is no negative feedback.

I did that now. You can find it at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--m3ixujeyfvwblqu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhjlbIACgkQj4D7WH0S
/k67nQgAgpWqoq4/8KV3fAAkcj7a4wsaXGcaCZyk+QMz7ntMnAi5EuKpQvTGfh6k
iVEtwKlxNmdKEc391k5UGBBRBjHsXmnzMgrHt3q3RON5FcQuElQugyobX9JBVN7v
m1BdY045o5Sg3Qy0yfrIJM0N0b8Ot1u83yJ/Y5bWpivta8CHKkUW8EVL6q+0ESGC
n6IPJS1b23h5aD7GZ4i5720SwuYpeJVlWeWZxktJVpN4m96MNRRVda4gH4j6/bnS
N3kxsddBiCwJWOXPm8/mxV6UGBYFdOx1HKHbf/MoNLsDNbu8uMw7FLUCV0WZijiH
zd243jZ5Q2EUuOm2zsvl6CQ7Y9M8sg==
=4sZk
-----END PGP SIGNATURE-----

--m3ixujeyfvwblqu5--

