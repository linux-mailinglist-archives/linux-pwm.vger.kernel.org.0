Return-Path: <linux-pwm+bounces-3957-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B99B4724
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 11:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3A01C2254B
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 10:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16B5204924;
	Tue, 29 Oct 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qLKYBybE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609A204934
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198652; cv=none; b=DL74J81xeQyvWcj/LJ7jiQVnpz4cqnR6lN3BqW5qkV7hkS+/vcXkGmAkarqw7TmRzQzW9PTYehWr+34e5jB7UlkjK66054kIHEPpffp3vaFwQ+VhSFyfREZF0gE2qDC1ABcgi2g/BTd7ADGd498iSqJ69htmkzzqaLssh8tEXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198652; c=relaxed/simple;
	bh=08v98m3masgehHn+A38/furMQeUNpa14MNDKpKMLv4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxDeNiGJodvqCfd9uEX3CX+yAEFf6wpaEksduhY4VMT7QWkkR0m+4jr6v32VnwSNLILq5QcW/0hb/qjTBsSSEWxLaidiTdU9Zgrxq8CYDC+00rLvwo1Nv0QTFBLqzadwfn3SFV3TF/R1bBXGmRCBwuJB/8AwLt7cP75ZGn4ZMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qLKYBybE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314f38d274so69760745e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730198648; x=1730803448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uV0lBLqUhbRGXbbqopf6xRDXiTg4koFgUnIUJCqwVao=;
        b=qLKYBybEjz+kCqpC+vqQJ1hqfebLKQaMkVtY17DbVf2YPL8UaRce6ki54/rdWOwWMz
         Eld7RwIVK+hOizbH+3W8WPdRfFQ49NSs5Qt570YVDQs+xh6a+vaOwGHLeBrd8N6uBnZT
         Irood5tpNEwo3PVm8h+E+h4ytJPgIihZeldZM8dkUhsoSu/pTGIBT+Ha5SveVoJupBrj
         WZoYLD9wAdI22RTnWyro4RqxXEqLanfq1pIctznZoFx7uOxTbdz+EpcyVq0bYNUe3/Mr
         vUPAvYrIld5Q4aMfAiVFxrbWQEYsCUPo8UJSVgz948vj8rGEQF5iVG+eYIA+5SmgHNNT
         rgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730198648; x=1730803448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV0lBLqUhbRGXbbqopf6xRDXiTg4koFgUnIUJCqwVao=;
        b=NATKsSC2NAISAfbXzwcdrS+YWkLWST4ufh/xBCwL+zciZomiN5F7XVIePfbV4Pmpex
         7mmk2VZwKD+rnLPpO7cgbYBv5UzEt3XjbSfUpECFhUNuCIRqJNzkjdpRN4taxAO3DqZU
         I0B5L5Aym29p9lm9aHTVOujY3Afaf4nkw844XRFbNVp9IIGivuFhC8LOWQBSnMKxmz1A
         uQkH7Y4wBtXGjR10bDhkRXgUnMrOQeKQGtyy1wJRxqN96hgK0Txk4LpOrNHImyls/8J4
         hqwxmB5mcaAoqjcgACGrJErNv3hrqZwwS9OyUxQ4psAnA0VLkvTOKSe3CcznsACKE59L
         DXxg==
X-Forwarded-Encrypted: i=1; AJvYcCUAdTZx6dKERSkUEPcDVggR07V0Rs1qVBaS6R85oce5LW5bUMVBDMV5vP21YSQrwGaK2jrkmzEaHJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYG8NgsAJtNlcCl6zNP/N97mV7N839T9L3cZS5bm7Lclfh4JUZ
	bsGCO+xy0Lx6n3bYiTpBdqgO+9Yd0pxzK5sCzJL+Ttn5Yn5Ljqb464eYtwNtRnI=
X-Google-Smtp-Source: AGHT+IFDd9toNEVebdV6GM2H3JKBp+TnL/N5UFyps7M6//NaEXMseAjAq8HwH15HVV5Fc5y5sz8WpQ==
X-Received: by 2002:a05:600c:3512:b0:42c:b508:750e with SMTP id 5b1f17b1804b1-4319ac9a785mr107122565e9.11.1730198648310;
        Tue, 29 Oct 2024 03:44:08 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b92f11sm12079610f8f.101.2024.10.29.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 03:44:07 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:44:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, justin.chen@broadcom.com
Subject: Re: [PATCH 1/2] dt-bindings: pwm: brcm,bcm7038: Document the
 'open-drain' property
Message-ID: <7aok7zs7whxfg3bhv7koxfxq6qhgv34b7kg3mh526z2cf7e23l@ffbsxqdqjis3>
References: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
 <20241012025603.1644451-2-florian.fainelli@broadcom.com>
 <20241015163200.GA1220909-robh@kernel.org>
 <252b6f39-3b06-43b7-b227-1c29c1c12bd5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4cvjuzgzwtcm6jma"
Content-Disposition: inline
In-Reply-To: <252b6f39-3b06-43b7-b227-1c29c1c12bd5@gmail.com>


--4cvjuzgzwtcm6jma
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: pwm: brcm,bcm7038: Document the
 'open-drain' property
MIME-Version: 1.0

Hello,

On Tue, Oct 15, 2024 at 10:07:10AM -0700, Florian Fainelli wrote:
> On 10/15/24 09:32, Rob Herring wrote:
> > Another thing to consider is for any PWM controller with more than
> > 1 output, you might want this to be per output and therefore should be
> > a flag in the cells.
>=20
> Yes, that is a good point, this controller has two channels, so it seems
> like increasing the #pwm-cells might be the way to go.

So the idea is something like:

diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
index ab9a077e3c7d..d18b006a7399 100644
--- a/include/dt-bindings/pwm/pwm.h
+++ b/include/dt-bindings/pwm/pwm.h
@@ -11,5 +11,6 @@
 #define _DT_BINDINGS_PWM_PWM_H
=20
 #define PWM_POLARITY_INVERTED			(1 << 0)
+#define PWM_OUTPUT_OPEN_DRAIN			(1 << 1)
=20
 #endif

and then add support for that to the core and drivers? There is some
intersection with pinctrl (depending on hardware). I wonder if
abstracting this somehow using the typical pinctrl properties would be a
saner option??

Best regards
Uwe

--4cvjuzgzwtcm6jma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcgvHQACgkQj4D7WH0S
/k4+iwgAjc7XEedu+25b7SNYH5vkBjaMm+K01V70SIUTshAMpLovuNsjbzQq6gNo
SJIwRMnsjcofeOlME5jeQYNZFA+M1nq9cihDvbUntoS2ylkwgNhFggKKQPXQ8goB
uPGWeRngZsmodqIRBw6nSQgGXlELsQkBchj3pM9XjlOKApNq1SKu9VqgQVY/C/ku
ObxIaFk4POIAW/W4VUm/sTpP7do75qWVemdrckfEs3orE/1x8w+9JKEYqQmus8vQ
yeVPDEVIFAnI1rx7qXUOH3ojZRhAsom35euFMSY0oumokNN0VUQdkB0ZVPr7O4fn
0On/5fTjF4nnOTVxM1IrMrqLNz9fvg==
=tPDq
-----END PGP SIGNATURE-----

--4cvjuzgzwtcm6jma--

