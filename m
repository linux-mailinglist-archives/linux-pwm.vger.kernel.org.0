Return-Path: <linux-pwm+bounces-5210-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF519A65796
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696051787C7
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Mar 2025 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443319048F;
	Mon, 17 Mar 2025 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr2X+Sv0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F51CFBC;
	Mon, 17 Mar 2025 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227706; cv=none; b=AVA6u9TTVxdoIXXZvzaD+ylIaX7QYgIIlpLAM2NKVau801A+9FZHH1Cv0iO2mFquHGmRsp6iuaNYDpF54PWdN3Prc4GuHa699+6SXZmjT07s+vswlfhA6Y12zwEbM041/fxwctUkXFf1OOwROzCLUe9zKjKYM3bxbyjDwrkNPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227706; c=relaxed/simple;
	bh=Sy1paDPH/ZLvD7USmysYgAJLpxitg/4Ltm6CfZWKWZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0R63jajzyzeefvtEF9pMdYx1Pmf4PzjMKo1Qf9xm9uIV/tqAxABB552s80JabPyc4iLq7meRKjVJ0k75UljbBG8zJKsliBca2V7MG1kFfcoMlyBnh5fWoUa5tODtXscHbuS3yMu+zzwsRQr93Kz9DjB7CyVH71B0O8H5AOTc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr2X+Sv0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso2637463f8f.3;
        Mon, 17 Mar 2025 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742227703; x=1742832503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sy1paDPH/ZLvD7USmysYgAJLpxitg/4Ltm6CfZWKWZA=;
        b=Kr2X+Sv0cI/LtgPns3fgXitzeMf85IF5F1yQGXymerjyHhIDgS7xB48kF9NPA/Sd/t
         V9we34rSm89uCzlGVPuJgJzmbR0hOBnni7sp6VgJNPCMrz5tqB/bz01O5P7MftymZoV/
         XqUemzYVT2ngbjbpixLMS2s0nXPKMb/VwWV/JLRHb5w8iENUxn96bF2CvI33NIf0PsTa
         VI1R9/oBaKI7Mo9UYrD1Ug85Efx2VFbMMQrdeC4AfHwHwH1acfXB2Ox3VzuTjMJad7zz
         yDwy+DjTVTAwFrU8Qg1q1X9iBT/yVW2MxJKQz4Xshu3RtVA3gft5WLC3Es2SEwB0KqTE
         AYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227703; x=1742832503;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sy1paDPH/ZLvD7USmysYgAJLpxitg/4Ltm6CfZWKWZA=;
        b=uZy0It+YG6APBewj9BThWclVFoaTrXg5MaKz4LqShNB81lTjkGYrLzmYgmX5kaRyZy
         tdKKbOxdhqWq6fD2hkVAawX8PpumzKhsVZQts25ae0cYW042JKyDIvt6x5DL250QYcJb
         6ZvYcbvesdzsBRR34zZXJypAN9SsthT5xil2TrcZphnQz+XJ/biERK8fOPpfJj5EAJLh
         ibyAQX0hnQvQfbhPnFxQflyIQpz3uWtSoTG+Cwr9lF+n7wCJTnpL4aFaIKS7qlVNSEkc
         hGMq9yGnnW5nxZnwZXJT+XGFPN/HMlgTSmUK8gIAUuF9MQw8gxcHVs3YcJocZ37I7kvw
         Kp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3nIQBFAE5E0dalAIksM7vk4rmQr0CanwjaE+KksE3kQfBjOftpQsyC5fzF+QKl4zUlprLta3Jnilz@vger.kernel.org, AJvYcCVTgGvMKJIBM71jjAnMu++vNtISnQrfcT3DXgmlK0LFYAAa2wK9nI14STInDYpPVQC15hkm+ErfVOSsYjo=@vger.kernel.org, AJvYcCWmvsQqPEmcI8abSRbd9ls7qAIAtZV4TS1wP3sBfxy31sESNTOMP+ARkDb57sFHC/LjN9xPiZboihLZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxEVblVd7xYmQ+Hq/9ocGmO9M2juOA2uv9wHKEA+/bH19BZ3eEA
	10fbdbqkexFFri6pNWScRrfyJVd9WadnOjQru6soPKoPilLbO7i9
X-Gm-Gg: ASbGnctne/Ej4zQd0GBBjtILiM9r2fw80ZYNI8/vwgrhgKZ3CtK3K82nDqLI8ou10f5
	8+n2oQDfSqKl5g4xXcBBETpTo9f1ol4KLlHiJHWdvxMKNuCc93vekvieDSj+PsHxmpb6SL3jvqR
	M1EqARIf8FwSf8IvRLdpWA0x3cyGGcBcl+LegxRVjA2yTO7Dx1NkgCd8iS9mLB67aK8p8cSOohQ
	c+b6KBGXvGjZxvYbIsKZXRLjDo070BQhwIOf4lWacHS2TGnmlb1I110xAuF1rbqSu66EQ/ialWt
	PBySo9eRe+gq1Yetk9Z/Xg/VKzJZ1STx9THkouxBZUI+KmeO00oBNMNVYv6Sm1OUhHiMcroyr9G
	uKMZ2DfU7fKvqdH/V
X-Google-Smtp-Source: AGHT+IF5kBt+cfFLKGH1h+7sG1GEVWIyfTsCNr/+EWGcTD3V+Hk+Pj2le0uKRNYUiYA+hnwFtB3p3Q==
X-Received: by 2002:a5d:6c61:0:b0:391:2954:de27 with SMTP id ffacd0b85a97d-3971f511653mr13364631f8f.45.1742227702620;
        Mon, 17 Mar 2025 09:08:22 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm15631243f8f.39.2025.03.17.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:08:22 -0700 (PDT)
Message-ID: <f6b32aa2dc60d14eae2afa7be3754c3f23c431b1.camel@gmail.com>
Subject: Re: [PATCH 09/18] dt-bindings: mfd: adp5585: add properties for
 input events
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>
Date: Mon, 17 Mar 2025 16:08:28 +0000
In-Reply-To: <20250317155300.GA4188705-robh@kernel.org>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
	 <20250313-dev-adp5589-fw-v1-9-20e80d4bd4ea@analog.com>
	 <20250317155300.GA4188705-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-17 at 10:53 -0500, Rob Herring wrote:
> On Thu, Mar 13, 2025 at 02:19:26PM +0000, Nuno S=C3=A1 wrote:
> > Add properties related to input events. These devices can act as
> > keyboards and can support events either via a keymap Matrix or through
> > GPIs. Note that the device needs to be an interrupt controller for GPIs
> > based events.
> >=20
> > We specifically need a property specifying the pins used by the keymap
> > matrix since these devices have no requirement for rows and columns to =
be
> > contiguous without holes which is enforced by the standard input
> > properties.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0.../devicetree/bindings/mfd/adi,adp5585.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 188
> > ++++++++++++++++++++-
> > =C2=A01 file changed, 187 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > index
> > 87256a37b5f4b6a019f581b164c276d8805d2e52..e976c9240df79afae1d0949e6ac91=
d477b
> > faceef 100644
> > --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > @@ -49,6 +49,85 @@ properties:
> > =C2=A0=C2=A0 "#pwm-cells":
> > =C2=A0=C2=A0=C2=A0=C2=A0 const: 3
> > =C2=A0
> > +=C2=A0 interrupt-controller: true
> > +
> > +=C2=A0 '#interrupt-cells':
> > +=C2=A0=C2=A0=C2=A0 const: 2
> > +
> > +=C2=A0 adi,keypad-pins:
> > +=C2=A0=C2=A0=C2=A0 description: Specifies the pins used for the keypad=
 matrix.
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32-array
>=20
> I would would assume there's a minimum of 3 pins (unless someone wants=
=20
> to implement 1 key with 2 pins) and a maximum number of pins the chip=20
> supports. And what about constraints on the values of each entry?
>=20

Yeah, I have the minimum as 2 pins. I define those constrains bellow in the
allOf. I though I could have a default in here and then later overwrite it =
but
that was not working when validating different combinations of values.

> > +
> > +=C2=A0 adi,key-poll-ms:
> > +=C2=A0=C2=A0=C2=A0 description: Configure time between consecutive sca=
n cycles.
> > +=C2=A0=C2=A0=C2=A0 enum: [10, 20, 30, 40]
> > +=C2=A0=C2=A0=C2=A0 default: 10
>=20
> Use the common property "poll-interval".

ack

>=20
> > +
> > +=C2=A0 adi,unlock-keys:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Specifies a maximum of 2 keys that can =
be used to unlock the keypad.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If this property is set, the keyboard w=
ill be locked and only
> > unlocked
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after these keys are pressed. The value=
 127 serves as a wildcard
> > which
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 means any key can be used for unlocking=
.
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32-array
> > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 anyOf:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minimum: 1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 88
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - minimum: 97
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maximum: 115
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: 127
> > +
> > +=C2=A0 adi,unlock-trigger-sec:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defines the time in which the second un=
lock event must occur after
> > the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first unlock event has occurred.
> > +=C2=A0=C2=A0=C2=A0 maximum: 7
> > +=C2=A0=C2=A0=C2=A0 default: 0
> > +
> > +=C2=A0 adi,reset1-keys:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defines the trigger events (key presses=
) that can generate reset
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conditions one the reset1 block.
>=20
> Are these in raw key values or keymap values?
>=20

These are the events number as defined in the datasheet. So, yes, raw value=
s.

- Nuno S=C3=A1

>=20

