Return-Path: <linux-pwm+bounces-3844-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E14DC9AF3FF
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EF7B21B84
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 20:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4AD21730B;
	Thu, 24 Oct 2024 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ePN7mLK6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CF2003C2
	for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802719; cv=none; b=ZtT9gYu5MgWls2hUs+SBkRleEORYKpFVbtk5Qoo9FhEwUIG/Xx8rqJTF8g2oy5/RzCEhG3v/pTIb7PgbvKxT49L3+NI6OpW1kFLZ7LCeNVvY4r4WMungfI2lssZDmqF7kB4lEuqxReDQ4xfnxreHgDYn7fp2rJdKHshUlXmkd3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802719; c=relaxed/simple;
	bh=Q+fR9l2sHxImyRgGXfduJ3cu0r25lFbFIDqtoFW9+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EawStD8ZrU9O8yVG8ZBrDEldh3PUqW5/U05K5icyqPV+dbSKB0eYn6bPBwiWP4C0gatDMx1uSr1VhB/wBLejMCU/NWtu5OfPJ21su+8vFBqbMa2fvwz/J1nhQLNGeCRb3k5gActBKprDopfx9lPdZnjwnaZ6a1GvKZ2TX1Dr9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ePN7mLK6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so13669875e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729802715; x=1730407515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+fR9l2sHxImyRgGXfduJ3cu0r25lFbFIDqtoFW9+0w=;
        b=ePN7mLK6a15BtIhBvXLeatxLreK8PoVShCPCranqAJXLjCDiSFS0RBYrTIKrhXXTty
         mh4fMBfANfHHc3zg76npMNTZsPLUupDnUfuhCAsRwlnlxIJgPiSiyhCaxm2o3DAduryx
         khwLGu02CfEYrd+P1jGkbThdGolc2X5GJ7HPK67jfc2H0hYssV1wQd8++h+i4iLUDO5L
         AhlVvFNr2q8xJKnB0Qs0XK3Y+dDAFfgFJmI0eoHDQHxXykSvXlMmiIoDjRqEkSYs55wE
         RFJEnfz6DvWtre/xc2F3626vjnQNYZ2fwjwDuloFd/GG6ysUedXJDq3qwwWrNI6xL3q9
         BVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802715; x=1730407515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+fR9l2sHxImyRgGXfduJ3cu0r25lFbFIDqtoFW9+0w=;
        b=KrylTkgn4uVhCGLG9XhMqaTf9v38iLndgrpUmD0T/07tewnnRDHKP5Vj/mDcnNydE2
         hAd89NjiwUQsIS4L6P64c2Akej0ysLzFjwq1BITlj5VqWeN0XZmli70L4YduskZUho6C
         T33cuy3TODde3nTCvpHk1vPAgq7uTLYf0U/ePLZhh4PZnP6nFvWzY7ZkwS19jgYc4X2y
         CVAG2i1rTs79tivTSzGlT+t6W+3NYOoQj8OnDiksPWaDjALTJZmR02qMyZuV0Dbw9VL6
         ca9MbS0EqsoTXk84Qh6XYoHok2SIIli/cVpSYgWsLEexaSaCcTVBqFEyRbhqdt6Mj7Ip
         hmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV0ib+wnOhLiwMjA2WKGGu3rzRdPZjurMIv1W1JWQBKGjERG27jTceP0686Nv1npnQKgNsRB2o8cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGA/ffqTxQ/x4zHgAh0I3MvWMG8EmvKliCm1YHZMrnjWIzWna
	XC0nN+YAaJ/o+Xisu0zN0nYhUXqr+SilMKNqaHff8RdQ/J2nGcCpmRrJvB+v8SM=
X-Google-Smtp-Source: AGHT+IHvGVeoznsX8V6zHTEd245vBgLpiLr0qFAYdI1JNMFpuVThj2Y8Gi/XqXtXbVcL4b99K0LHKQ==
X-Received: by 2002:a05:600c:4f8a:b0:431:5c7b:e937 with SMTP id 5b1f17b1804b1-431842098d7mr70085195e9.17.1729802714949;
        Thu, 24 Oct 2024 13:45:14 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:b203:5494:7e5a:8c7b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f39fsm27948465e9.12.2024.10.24.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:45:14 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:45:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: adi,axi-pwmgen: Increase #pwm-cells to
 3
Message-ID: <tt47zamkt7k656bm7u75bfrbc6uqqge5to7tyhtt6pip5a3k5m@ehdh7tvipty2>
References: <20241024102554.711689-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="idekw6ecpafqoake"
Content-Disposition: inline
In-Reply-To: <20241024102554.711689-2-u.kleine-koenig@baylibre.com>


--idekw6ecpafqoake
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: adi,axi-pwmgen: Increase #pwm-cells to
 3
MIME-Version: 1.0

Hello,

On Thu, Oct 24, 2024 at 12:25:54PM +0200, Uwe Kleine-K=F6nig wrote:
> Using 3 cells allows to pass additional flags and is the normal
> abstraction for new PWM descriptions. There are no device trees yet to
> adapt to this change.

With so much feedback I applied the patch already to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
with the tags for Nuno, Conor and Trevor.

Best regards
Uwe

--idekw6ecpafqoake
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcasdQACgkQj4D7WH0S
/k7CmAf+KQVIEpJ6g+LlLNwpbNNRmGcxid3cSBaI39/gVk6hyu94T0rWh6NFl2I1
h6Ncblt6zmEouo2zfP6fNS45lnej+nGubzOUeVOwVhm+vxPJatOHhTzuIkigu/5t
1dlXcHeXSYvc4YhWW+XHmBdG7KffqS+8NoSWOv3RixTcENeDfBjfr66PDNK3P9vL
H9FhcoBX5kvvGEkGf1M03NkOxBWwabyjb8UhyKtFPWwZYiBDggnAj7tGjUtQfbKJ
+Nr8qpgyzm7mhRtMBqooiw543heu5Fzb0nD5Mp0OkEAvZojNVU2j5wIP/BAUYf4r
hu50FFoN/fk+i8cRyOTRDF7Kh3H/Jg==
=GvtY
-----END PGP SIGNATURE-----

--idekw6ecpafqoake--

