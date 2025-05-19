Return-Path: <linux-pwm+bounces-6026-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD7ABC459
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 18:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188AA1639B0
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 16:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBE62874FA;
	Mon, 19 May 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuW2D6j2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5927A911;
	Mon, 19 May 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671552; cv=none; b=k3WNF8lBEjke1Y+b30X40OMIF9WmkFW8Bq5wXDPH9CSYjun3kg1fy5VrFTh1CmIj/IXxW17S2CB7EtkNTgr6FUTggeFWl7IvgeoGJkiQAyIwC9oUgjXd0weAH8k2CAlr/fMhcngwxGBdRR9I8PBQwlpc7gmmldmwoR6qTEaxNJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671552; c=relaxed/simple;
	bh=dmYdD+igyaG110JUikTrc3t6WrlibNxxN48pbj5kQog=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VA4wXJ1QziSVkSNDST1D8eCgPBjSD7aL2AZBkN4iO2B5qZZic+OkyBNPfEt5K5pFd1vTQ3gDbVwMGmn1pJ1MJon2SQlK49wASZZRbGc6Kic4KaJuCQdRZS2xVBoW2BOx96CqcRCIpFZ6dCFS4bLMPu+sum7jZ2cldTI3//iVl9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuW2D6j2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a36abf5df9so1150034f8f.0;
        Mon, 19 May 2025 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747671549; x=1748276349; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmYdD+igyaG110JUikTrc3t6WrlibNxxN48pbj5kQog=;
        b=OuW2D6j2iyiNhQeU1Y1mI/Pte+DeUDz9mcKwo650Fvjr56pP7mmatbAFCvqqOgeWah
         bZueLYh7dzcj7tpWJBXlumvo5ii7ocwWGI9F4lvilJs9KgcqUGfrIfZXf9O4Gy1dE1Et
         Xd2ogGpDzdJB0vgAD1wtsnyik8Ro+a8Wz9zJidMFRtPCtQoHQgHZok/KyeF4upYvnRSy
         fTnHi6YLQhkBtAa1vkjJ8/6XUlGFpBz3pMXlZihDPvd4iJBgoSLpzO1sl6SjXrkZri73
         KeQH25s5NSmTBZO3bnbF2/vDtd4imaGLvIu3uDkgnPC/HNJl97qyW2ZbjUHeerdMjeMN
         WOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671549; x=1748276349;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmYdD+igyaG110JUikTrc3t6WrlibNxxN48pbj5kQog=;
        b=cyNYzTfFCB2C748Su5QSmNarICweXLRWGgEa81fzxVGVh4EQlugxCtvK4mBL2zf8q4
         q+w/9z7VzgnRgZl0kyOdEANSADz3j0NIWWvWfUJ8FCx3Vbna3ETqFR/8kYyrf4VM4iFz
         bwzTF+BhQrQSAQx7bDnene9pmapdSzSfSwpzdINYWL1d1azKBJU05y99C+ox0IzeOFOf
         ox07WFCC4fmqlJCW9tBw7nhVe3HiDsJTH/H+CFFDdQPrry/vltsyp+L6KKX60O5fDlQo
         7wa+7qU2f96IluvTMmhtPiygW/GmEoiV1cqsuOrWZ0rWI0WS2tiMpF5IfGrQeuvRxY4p
         n6yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB4UOQ9MA/HsQu8mtRLFzapjbsgdVnwSyvtgIGaSyGlJKSE87TwFG2Mz3qf/uWyd9fkL6aaR4zF5hNYD4=@vger.kernel.org, AJvYcCUXHrBUXFyRQPTBZV/qlKiMPLuLDKaufOk5D7aHBESCrE4E/NC5DOvf9a8ltUOi2E3cbKGfve9yfffe@vger.kernel.org, AJvYcCW//ZHZpLrJYKahtyUnUF8dQFNaQq5Sk6t0/gF0ML06h1Wp9wd7cKVerWPAf+LQPaPNsimJgSqI2iZc@vger.kernel.org
X-Gm-Message-State: AOJu0YyomvON+eROfEU4vU34t2kaRyAnHstJU++9M4ikGJfufhw8cIQd
	sOg6hw5GWAlrT4t07iVXt/JKec/geyN7aU/jIYxQClyzv9dM1H14hEix
X-Gm-Gg: ASbGnctrW6b8GZ8pl/wmyG3JtsEa5tXkZ+mHRwIsNvFI540aB5nI2tjMDJZZTyKqt8I
	VNSwOFSiR6ubQOiJIZJA2np0D9rM0zGP4gmIn6ap8LjVCpgfhn/+DgTC815oyCr8qsVR5NVXmrR
	01BKdKfi4u5Dk26YqVTPjG7VlOyWhMT9pDro7oxKR21dcAP1xMZE60qxDdj/dN6xLJTjm7QDxLs
	PY2LhTxWhlQ3+dw+Bnx2kqvwDl0ioH/EGY09wse8Eox7Faq9nV+dbFgcu6YEmpgt47HW6J3VmkG
	brG+dwQatxp4MIzHws2oRUmsWzuWFxciLH3v71bTGro7eoA8vMg=
X-Google-Smtp-Source: AGHT+IFAa6RLopD4JWjuSn0eyxw2ixMGoxeDNXv/nXX1EyGGQLL+LcRYbj+X2Kipp1i/mTeY9yfMcg==
X-Received: by 2002:a05:6000:1acd:b0:3a3:7675:902 with SMTP id ffacd0b85a97d-3a376750abemr2304299f8f.21.1747671549109;
        Mon, 19 May 2025 09:19:09 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d0fasm13471852f8f.8.2025.05.19.09.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:19:08 -0700 (PDT)
Message-ID: <44dba598e27905dd6f129307fb534c04ac072897.camel@gmail.com>
Subject: Re: [PATCH v3 22/22] pwm: adp5585: make sure to include
 mod_devicetable.h
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
Date: Mon, 19 May 2025 17:19:10 +0100
In-Reply-To: <gfrckmiyfo3rnvhnryptcwtwlu37aaga22onpra2yteelwl3zq@b6zaszmd4axp>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-22-092b14b79a88@analog.com>
	 <gfrckmiyfo3rnvhnryptcwtwlu37aaga22onpra2yteelwl3zq@b6zaszmd4axp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 18:11 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nuno,
>=20
> On Mon, May 12, 2025 at 01:39:14PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Explicitly include mod_devicetable.h for struct platform_device_id.
> >=20
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0drivers/pwm/pwm-adp5585.c | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
> > index
> > f26054c19c2e154d05780af09aee1b2431eba2eb..93d0294d048abfe1a009161025e65=
8b58b
> > 669cd9 100644
> > --- a/drivers/pwm/pwm-adp5585.c
> > +++ b/drivers/pwm/pwm-adp5585.c
> > @@ -20,6 +20,7 @@
> > =C2=A0#include <linux/mfd/adp5585.h>
> > =C2=A0#include <linux/minmax.h>
> > =C2=A0#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > =C2=A0#include <linux/platform_device.h>
> > =C2=A0#include <linux/pwm.h>
> > =C2=A0#include <linux/regmap.h>
>=20
> This looks relevant for the current state of the driver in mainline and
> doesn't depend on other patches in the series.
>=20
> I applied it to
>=20
> =09
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git=C2=A0p=
wm/for-
> next
>=20
> and so it should be included in the next next.

Alright,

Good then that I first pushed the new version for the bots to test build it
(before sending it). Will drop this patch from the new version.

- Nuno S=C3=A1

>=20

