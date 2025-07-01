Return-Path: <linux-pwm+bounces-6625-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1038AEF30D
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 11:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF279188A591
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE03C26E146;
	Tue,  1 Jul 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGvLxSNn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C026D4D0;
	Tue,  1 Jul 2025 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361537; cv=none; b=S/RUcIQP81f7HB/4/DxETbaP5iu0g+YsrraB2NFwpMzhRpWiAILfSLQdOhnZEaPU5BXJ6+8klVAall67S11m7ixS4ydf6xrUazD5G9f/UhuTwVt4a47Ck32oolQeN/71NsBMj3vbieagTNyjmdOBr7ThffH6LhBysPfbkyMZVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361537; c=relaxed/simple;
	bh=rIbH4kTlE7Qo2Uv74AcbRUuysU4tBUcmCHdYS1/ElSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7KqJuOm9BJ2MT30yjmZViCacxDj2wEtmtAne2AxhCHWNlFdKt7drxrJ/f6PYSNbIRV5uqguviIHOaiHGJQZe7TNMxD9tyJXC2MzE+Nx0fB4KDLFZSUd9fDdEAMqGBXUgC4dUo6kDaWXMUMJ6HO5XtKA9L95POkkswMNaW7NDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGvLxSNn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d3f72391so31730505e9.3;
        Tue, 01 Jul 2025 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751361534; x=1751966334; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rIbH4kTlE7Qo2Uv74AcbRUuysU4tBUcmCHdYS1/ElSU=;
        b=iGvLxSNnoyYmhxxvM18C2F+1msZrixA5wGjmvbxh72vogaYJtGUu8od9xlf22LzDm8
         ig+56kLbmlhExaON/OvwTMC+wY8VoQqddMRLowl+KD3zcdSwjPPGnggfhh/yFt7La9BZ
         x6wJ5yzun63ht2dgVH080YJia96NhSqXWmG/Si4DxJXqMkcK0FXjnEUCEHB6FbnYiGa5
         Tr8uTiBt+Uzj68bybXIIql5QPmKkxK40sqOWwFwTCHnlz8GIFjJQKEZs1FWUYjaEUJlu
         MPn7JzyIeV1EulIpkxhIHQzq9wuEcEu0GNS+sTK/5bLkEFeMEiUwdrV3usizRVeolU+I
         NY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361534; x=1751966334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIbH4kTlE7Qo2Uv74AcbRUuysU4tBUcmCHdYS1/ElSU=;
        b=xGlfmFSheW1qAbn/Yez1e6VHdb9LC9iVcr4oTqG4pZyGCYiL73daq3GtOZCo0n2xks
         iRBnfHa/h+TW5HlegRXHfzxU11PxoFBnNbZbUhCOzSydbOdc2LfUDxcuHPq7O3aMxceH
         5whYtgQ+yoG9MScItLyQyHOGZaT64gXjmCmFpsfNM7g0EdcSAqPIIZZ/q/jPvGMRtu0v
         AZiV/ZVBz2+sOrHNZoWvYcN6jYOGu7XjthWfZWh977WWGra3z4CaVqW3i/5UP22M7Kvc
         1o4NWgXCdRemBI+pNtXNlKIUh5zsrekrBAdxdXLtqd/7dfPVkqK80UOgJsE0vh86QlhC
         rozg==
X-Forwarded-Encrypted: i=1; AJvYcCVhVPlc+ldBm7S21Qs+SNUGQWMTLOZwiw3v4vbO0O7oskQilwmHqP9RXLCoNb+d25kSgbnzI4SIGFp9dN0=@vger.kernel.org, AJvYcCWjy1EDqrm4INi5JvvqAHFK6oVcIs8r5FOgOPLyjIZ309gDBVYNlPMf8ikMHT9rqfQJEzglpIHIJCz4@vger.kernel.org, AJvYcCXelv5cnmS38xVXkyrvQbIV1s6kr5OmcSF61skurrDpLO5Lch9flOnNF1Ymkjyfeg9wS/kCn0pBu6rF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4URE0ihRhVddWdgXv5Y1OCLQ18AMdZsLpaDS4LsVTDlJc0sVZ
	5ruihMOXezPQc9i62lFZ/kH5rwNRXGUo1IaFDKgfv3PLgbesfW1pV0x59dbl4cMtwmQ=
X-Gm-Gg: ASbGncvVsI8OzXD+S5D8I82FJF5sFKxMi+fvXKD1GveleahtySmABaeik2nfm3llDBe
	+2dJ1obOUsQ07hsXUmJ0KtY10zOYOlajmgA48GiIVpFuVSgkJZ98CuJOQxypfGRx8Vi5HJO+sG5
	oMMeOwwboEAfvBFM6nP5twGaORmJZYYE2DL9mG4InuB3iShZdyVwEtI4EvJNivOd0xnPAbGNDHE
	Gad/mkFwzgiCYiFCohCalnzRGq6bV79PQKuD1Wuwi3IKIADeMkgiTMCbFYa5aG5ovOml9SlJF68
	+4tumglESt5gtLBgjTt4Iw6NZlfUrVeH332V3KaTejPCGBZDVGCyUegk6CPKkBuLnVzvafZcL6P
	8whbd
X-Google-Smtp-Source: AGHT+IHBwwW1RbByLj7eh4aejmfFHcJK7FNHPuotQaXEIL2rFRwU5gusrEM1o2mQTn6OlKl0p8GD9Q==
X-Received: by 2002:a05:600c:4ed3:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4538f244121mr171874975e9.4.1751361534032;
        Tue, 01 Jul 2025 02:18:54 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453941c67c2sm115268235e9.5.2025.07.01.02.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:18:53 -0700 (PDT)
Message-ID: <83685a983e2134fd644a8720383408d4b452996a.camel@gmail.com>
Subject: Re: [PATCH v6 16/20] Input: adp5585: Add Analog Devices ADP5585/89
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, 
	nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov	 <dmitry.torokhov@gmail.com>, Laurent Pinchart	
 <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Date: Tue, 01 Jul 2025 10:19:03 +0100
In-Reply-To: <txppsdw4w7ocnysvrm54ta4ulplwawd5pk2l5wt3bhrag6qbev@gr4ah7lgjigi>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
	 <20250630-dev-adp5589-fw-v6-16-a0f392a0ba91@analog.com>
	 <txppsdw4w7ocnysvrm54ta4ulplwawd5pk2l5wt3bhrag6qbev@gr4ah7lgjigi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-01 at 10:39 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Jun 30, 2025 at 12:53:07PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > The ADP5585 is a 10/11 input/output port expander with a built in keypa=
d
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > This driver supports the keyboard function using the platform device
> > registered by the core MFD driver.
> >=20
> > The ADP5589 has 19 pins and also features an unlock function.
> >=20
> > Changes in v6:
> > =C2=A0- Improve kconfig text.
>=20
> Is it intended to have the changelog for the series in the commit log in
> the end?
>=20

This is like DRM style.

> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
>=20
> I would expect that not, so it should go here.
>=20

I did asked Lee before sending v6 but He likely missed it. I would add it h=
ere
but it is painful to do it with b4 so I ended up adding the log directly in=
 the
commit message. b4 was removing git notes and I also don't like git notes a=
dding
that "Notes:" line in the beginning. Do you have any suggestion on how you
handle this with b4 other than b4 send -o $DIR && git-send-mail?

- Nuno S=C3=A1

