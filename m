Return-Path: <linux-pwm+bounces-5618-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B14A9509A
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B257A83E1
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365B26461D;
	Mon, 21 Apr 2025 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3yMmlZp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1A6264616;
	Mon, 21 Apr 2025 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745237554; cv=none; b=g5Bm6WEu+OdCJ8TqbDw27o7FBJ2rvXT/LgfZdpsoHiXkF9fWrRuRpoD6fH+eqmmyaxZyb/aps+deC4QLocqQzWQ4AoFixLJEhR8YWriN0qn7nw1UQq3F6mPyFUNVeKbjXe75xz+Fe6ER8F2n22UXmsmvRXPxHlStMiCFlWwbZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745237554; c=relaxed/simple;
	bh=oz/EesnG7lVuzRX2BWQPzMarpKSzZV5VD/odYRnEHS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jqoghfru2UAJck71q0qI+aOHnOAhQbFkQDFqq7XHybh+wjX8D909HbkVRfB8fLrrakNpzqfhN6CnqpS0BbOKEQlWDYKqiXBHuyOgDAI9j0H4Ip7P+s/SHPTFcI8yVNn3wGdkTrPyNuQg8Oj0aRIa7LZxHfd5ncU9bohInVDy/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3yMmlZp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c266c1389so2844340f8f.1;
        Mon, 21 Apr 2025 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745237551; x=1745842351; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oz/EesnG7lVuzRX2BWQPzMarpKSzZV5VD/odYRnEHS8=;
        b=Q3yMmlZp+vaEPNHk8yUFUOM0d6f+eTxLmnm7E2qdGJy5T0fOEd9zN1Thvuj0u5/bK7
         R6fpZMUD8Aa8GvCbSge9vDqA5L+0VN/TuRV6n/fzQExaQWCb4656gUzbe+IDDXQ35Jym
         NJtsXrkdWR7GHFBPUXasJJqvrZwQuIb5zTQKUqycU6LHprTgnUJPkIJpzBtmj7Y+snwR
         QQp1CCt1SY6nDnehin/Aq+HJDymvMQFzhZ1jR7PGPZadN1A9rtv8y7W4KwNvUB6zVmWn
         obqM+KmkRyrBEN86pDZVkCK1/EZq0UOzgfVfaI14w/wvgddYHdXDKGPa5rCr1jxcr3Vp
         VJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745237551; x=1745842351;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oz/EesnG7lVuzRX2BWQPzMarpKSzZV5VD/odYRnEHS8=;
        b=bLlFk4tBXydV9zuGO7RBtQsfOsUOn/SpU7RahPrrrWOExZ798ukPKwYSww0Rpj3Dni
         4mqLIc2zyNxnH7YerzufCianedJh0B5ljjW8HmlSEMDdYhlR8zs0DW8qsT2jM8qPiuzk
         6ARXT3fxuDzN5bO5uz9UlNAKlhPKsgfEeOOjYd+WlQKarZKXwrYYiz3q+r+AkYlQqAHn
         fnRPNEOkyqzDyiGOcc+NDkPCxq40jTuby5fyDKkNooq/lDXeCYFuNM4rc782upifSDLU
         t5LjSDhVtdZBsmbX8P2A5Cz/HqTM17upo8bKYkYSfEsPa5uNvciftd/evpbGgFWlOh/x
         oR0g==
X-Forwarded-Encrypted: i=1; AJvYcCUbEeg5/zwBaLPoJlL2bKO7C4xk9iizE66mA6NGkb6wG1cVEAyJavqfu+CHkcsXTgA/YH5sVxJWJ6wq@vger.kernel.org, AJvYcCVqWAq0hxsqccoLzwCTCncPuoHVS54H/dTpiynkELtqKk9zA3xM9Vn3YZ3Y+EgolezKkxnxRacGnGQh1wc=@vger.kernel.org, AJvYcCWcD0d/skasYVmkZ2S4FUxt9OYH09wWIbv3HES0+8j5zEes2i6QPBsmkkQPFGhyFB+PPQD0v+CQO3e7@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxX3LCkErMijyAQ1CZsmo91g3PMgnVIcuhGEQBmgsGWXPlGLE
	jf4kESv/XclJhJccINY46NWa1QrvTWjpieOkOi/49xfFIRPBzZdq
X-Gm-Gg: ASbGncvvwFINvlm30O5fMdKbW0J2r7ylOPHkYQPw1Aj3RRE0l/42CeJU88Awc686ipA
	0ZU498owJV8fu6xAuo12zodbsgLPbPFH+idE4TIG0T5e45jeg/qUEW+t5WFPRpImS4junLLjtz5
	lmSiQ0/hjPGdiHZUd2Va6wPwnvbiltZvZkz9+B8cBGyzR7apEzEvAbzVv/nrhhOIgx5eiH6efyi
	OlwgmYjnydeZBNPLqCpOcSidegOl27uPVTkb6vzrCsph6/932A1dwZf9wnMpEXdDVGLYWVwX7iP
	LlBzraGUCbeBqDkyEQP+EWENgCGMqKHHxSBkP6wHCaYyKmqiro3+sPcMUaNRlkybFAn4ALqHiNU
	W5cXadcwU+5Nb
X-Google-Smtp-Source: AGHT+IHyhxaVLgEe8TVcRlm+QjhQUpNKRGjTCVXiwtMyuS+p57fKxMIGwjD3lg0Z0Ac7KwH7kDcABA==
X-Received: by 2002:a05:6000:290b:b0:391:4999:778b with SMTP id ffacd0b85a97d-39efba5b7a9mr9261398f8f.28.1745237550982;
        Mon, 21 Apr 2025 05:12:30 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43d07csm11898439f8f.58.2025.04.21.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 05:12:30 -0700 (PDT)
Message-ID: <66dd1d165df00d271491a6a5d2a8beaa25f7aec6.camel@gmail.com>
Subject: Re: [PATCH v2 01/17] dt-bindings: mfd: adp5585: ease on the
 required properties
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Liu Ying <victor.liu@nxp.com>
Date: Mon, 21 Apr 2025 13:12:33 +0100
In-Reply-To: <20250421085605.GA29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
	 <20250415-dev-adp5589-fw-v2-1-3a799c3ed812@analog.com>
	 <20250421085605.GA29968@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 11:56 +0300, Laurent Pinchart wrote:
> Hi Nuno,
>=20
> Thank you for the patch.
>=20
> On Tue, Apr 15, 2025 at 03:49:17PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > It is not mandatory to use all the capabilities of the device. One can
> > very well only use it as a gpio controller without the PWM support. Thi=
s
> > will be even more evident when support for the matrix keymap is added.
> > Hence drop the requirements for PWM and GPIO.
>=20
> This seems to make sense.
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> I however expected changes in this series to *not* register MFD cells
> for the devices not enabled in DT. Could you do so in v3, on top of this
> patch ?

Makes sense... In theory, I would go with MFD_CELL_OF() but that would need=
 (I
guess) bindings for all the devices and since PWM and GPIO were not introdu=
ced
with that...

Anyways, I'll look into some "mandatory" property for each of the supported
cells and use that as deciding point.

- Nuno S=C3=A1

>=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 3 ---
> > =C2=A01 file changed, 3 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > index
> > ee2272f754a339569c793102928ddd13249f8fee..e30e22f964f78519b2ec207e9415e=
4897d
> > b5c702 100644
> > --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > @@ -52,9 +52,6 @@ patternProperties:
> > =C2=A0required:
> > =C2=A0=C2=A0 - compatible
> > =C2=A0=C2=A0 - reg
> > -=C2=A0 - gpio-controller
> > -=C2=A0 - "#gpio-cells"
> > -=C2=A0 - "#pwm-cells"
> > =C2=A0
> > =C2=A0allOf:
> > =C2=A0=C2=A0 - if:

