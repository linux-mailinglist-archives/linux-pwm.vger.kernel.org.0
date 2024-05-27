Return-Path: <linux-pwm+bounces-2242-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2298CFB3F
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8A2281992
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8598B5FEED;
	Mon, 27 May 2024 08:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpK3IUAV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431247F5F
	for <linux-pwm@vger.kernel.org>; Mon, 27 May 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798167; cv=none; b=brraG75RoklzPqVymfFT0sbfIglEfpdK5+eFkWfy9K1mmrup80A+9IIHNEShZN0kYit/XsQEjsTx6whDtlVIRJGstNFj7g6BU6Ixwi2MrgiWBbW8IWzxCNyTnk1jd5Qzle28Dh1XzlZA4If03BiXbqk4g7azxsaJZ73r4kLwqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798167; c=relaxed/simple;
	bh=RhzbyoYzei8nki7Y26C+6sE1qATDlhF0eguNRuXHJPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVRAIDXVqYsHP/DjjLFD3aWiG8EOpKHBNMAyHH/xQIuGMhlmjrKjjz1kyV+y+93TEoAF/cgx/5RravVNiMjbPZ8wjIgTYPAx+LUWDOWlOFUUrnExPQWtQoao4CT3xpnk5cwPLphBhShHmqLsjBc+lQPZCc21D4og7mQK82Hrkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IpK3IUAV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62a145e0bb2so23205507b3.0
        for <linux-pwm@vger.kernel.org>; Mon, 27 May 2024 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716798165; x=1717402965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhzbyoYzei8nki7Y26C+6sE1qATDlhF0eguNRuXHJPw=;
        b=IpK3IUAVHkuLq5cFBMWkOM9Wqr9LRKjQEzRonjO7sAl/0fTBdQOTmdKcWwPTvrVU7L
         qADdDgQomKOrpr7KjmMaciELdRUMRQmM5DVAe+g1z3RWFAhqEJFrhVeC/ZT4AUM4OqHp
         9zLmczQo+A/ZCcxPnF8paLOtMw7Jpg7kJZE7doZIoOwTyuWIlgLwpuOchV+8hwAdORmr
         Jl43pmXr5iA7UExMmWd8XOH0xcIDl2RS3mecKtI11SEKKaTYU/dddZn4/oAe4hb2KnXz
         zTuEUJfMiH0KZesUsYDL32CA3DPAN23z/fyQe8JjwVVyfrbzgRLxMd1mluG2I+Ov9k/D
         7x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716798165; x=1717402965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhzbyoYzei8nki7Y26C+6sE1qATDlhF0eguNRuXHJPw=;
        b=KpUV0cAn1fjl8tEk/hSW0tLGMyf40G4SWPnQ2YwDUhSLBdNTiecrLtfPSdtHnEoXao
         HsYYCiHfAVHbBF/LEGQ5p+oS/uMWXqRa4jbQZ0UVL2F6Hd76pzY3GfQDeyRmmLTSLwvZ
         CzAW4LBL0thWWEY4FhrDCVMYntHxMKFzk/X7O7BmmeaMSLXYmzuJr7Hg1JspvnPapdlF
         VNiV1iagXFG11kg9HlVu4enPkdbcAp7Nvs60lCGuxdcBoXF35HLAmFnyE5oloCXWUtcH
         U9ajdb5avZZ70I/+qN2eljPo9zOWep1zE2tzFlC4wBZ9p5d4F5/V9QHT0JXNzSu++kJw
         wxoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSTWuz4roqehfqge/G2I1Man2sprjmRQ53n7nJ297htehWsmR4SQmL15TfVYY4ru04Qb6sbptFmUesRY4jXfUVOZ4gVnl/F3gY
X-Gm-Message-State: AOJu0YzCUsPA2IOJtB6ycN+mERW2SDH0q+5xgnxTlHR9eCIf+h8ZqNsK
	K6o5iUvtM+JALK8g49UfiC2hJkhbp+PKLBLJG+ePXqTAC/Hnt1KLqMoZqutrHWHaEkKG82SC8HV
	F7vcPZOd3jIwXBhFTnNkNr101+Us6OgTzNJFILA==
X-Google-Smtp-Source: AGHT+IFmRtGsO9RnOjJLtqMhlOev9FBEcciYuxHiQcnDIeAfRLJmqIRkGsC2dgKZmDVlb84ZKNyPilf8+td5vWvPK3U=
X-Received: by 2002:a25:ad99:0:b0:de5:5084:715d with SMTP id
 3f1490d57ef6-df77223805amr7696603276.53.1716798165010; Mon, 27 May 2024
 01:22:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204220851.4783-1-wahrenst@gmx.net>
In-Reply-To: <20240204220851.4783-1-wahrenst@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 10:22:34 +0200
Message-ID: <CACRpkdYmOECdug1g2gYxjHZ-+Y040SR70UtDAgKD8yCb58Ob6Q@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] pwm: Add GPIO PWM driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 11:09=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:

> Add a software PWM which toggles a GPIO from a high-resolution timer.

Is work still ongoing on this patch series?

I would use the patches and I like them a lot so I'm happy to help if need =
be.

Yours,
Linus Walleij

