Return-Path: <linux-pwm+bounces-5186-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8350A60D5C
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 10:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F2919C47FE
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10F91DDC14;
	Fri, 14 Mar 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRZ3sA4p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7978F4E;
	Fri, 14 Mar 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944766; cv=none; b=Gq0avEBvPgZ/vNpOTY14Fa1TbT1LRL5q8R2aD6cqxGSwD7jggZ8i4z3GRJJFenS+NnsztBRG2I1wqBKiS+3GdAaZqDKIQDhvmrpOdtxvE59LOWug09m5QDW6huNoqn1CygKT7RVeIgHv5RPwuptKUi57/tjDTOWRtL8wFeiuOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944766; c=relaxed/simple;
	bh=hcV0LEzSEuwEKgpFGDakD0gKy0s+WRB99I3F9V6pjB0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6z9i6zRpr7lwBJADb2uv6IApD1l4H81iOf60MjMPrX+1/MkLp25/d114qc2801ZZTiXrRwmXn9t1K1pH8HHJHZUnV1JeMKUx6Yfbs6a0gberbXP0XFzgt65uJcAOc5aDydVAdyUWzcvw4ZbBlNFLiNSIKis0O4whoEMVcdOO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRZ3sA4p; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf680d351so18780645e9.0;
        Fri, 14 Mar 2025 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741944763; x=1742549563; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J4tYQIJAJBSXDPaAztr8rYlca+bGlBplSbR1xzd+zog=;
        b=PRZ3sA4pEjDG2BF7k5tUewi343wS7e6bAIyEZphn0iliIbklpjY2X2CAHS+QvY/Tig
         nSeIzk6/rNtEF4rNHgFH0y+MMs5xZLunHpfSHBc3oJr2/5G+eeInLpKX1yXgcGB1IwCx
         42/4/f1IQlReB6Ok/xcU9BO8Kw10vLWDfQp11wxMUaALLzOgnxwaHVxhQ+S/XpqDlFV5
         51TNakCwGmiXHQV48JVUiLWom1pjP6k/LMrEPcR3fMJt7zd+7Rgf+H6QqaZzTtBn2/Zc
         2/A5zWPdOYFsHqmTZHQUypOTQcm72/Jvc0U7LtQedMaWZuDfT/fxcNuT9b43IzLRHjVA
         KRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944763; x=1742549563;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4tYQIJAJBSXDPaAztr8rYlca+bGlBplSbR1xzd+zog=;
        b=fxy7UMEx6R797e1Qs9QR7RRqHfaJaDG0bP8x1sBRamx3i4s38yY0y08TQ/2QY1zor6
         ZinMJjii3gsVY8ZtElHmFNTRtxSooIguYuSpoi6VHQzWQhHmS9XLEP02vRnW1envU4FC
         S5L7ZgA5kmeUs5VfbN8PsjPmv+/NX4lPD3Z4vZK1kgqKL5eSI/tugdRCaK5JE+bDGI2b
         jsCIurYxeIijCEYfUBtz/A/pi42PqHQdnLTz2XBkhQ7z2GNMwTD7sKxB7j7/bGnaDcu0
         T6j2hCtzdKfydBsTKinPXMVqZiSX95Wxp4S2Opg7MOXwCH5Jn2cylJPTeR6djxzffnLx
         tA9A==
X-Forwarded-Encrypted: i=1; AJvYcCV+hk4NUR0XHgWZuIdzDue1/Q3xixCC/CD8PNs/vg9jhmCAVJJ5dtFo1z/MiBtwGhVQJ/5FWkN0KqqonIg=@vger.kernel.org, AJvYcCV4Fj7Hj+3ZsoM0/Pw8zyKeTDojO5wPgdyoODQcLYUPNSPApQAwg2v38F2SzUcUQ5a+/YLoiVpxQhojzw==@vger.kernel.org, AJvYcCVPpt8mNeppoJmA8lv6J9sbU+HIIbtZ0Uf6WTJats/bQQbPQhcn/HpOf2934+s13Ib1JvxWdjs3c1gP@vger.kernel.org, AJvYcCWcMgekeQNXfKop4QVU4y1zmrttEbrbTKWUXTyLXqEbpomwgR2Mg+EWkHWLDb1E+Tjod8hEcRO5iCbR@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoDtLSVBw3NAzRncLojM4CryYCSLj6VMd0Ct6jXlK2XVoETNL
	+CeUNiuRA6DSQnx7CsKJhTxcMi8lGOejJiW1ZEnCidDrji/ChBhP
X-Gm-Gg: ASbGnctj/soktPGff34UOOla1dlvLtpUmVqyyC9Sy0TLiZBvLJYLCL1WELjrcQy1wkU
	sigtPQWe7eczb9TLH22L9QqJMESdCia65G3d2BSF2gV+L10XDD7KofQxWmtD99i1AMSLjqWmjmz
	HBF6u/nss1B+TqARRK+MleKCrh15yDqZ5HS4ddXfo7DF/EyxGeLvgZtZj9xx9bBoPmqYc0Nj7S0
	Rs8yt1lxQScAuOszFE67MjV1z8CJ/ugq5gU3FnU3C6zikVZKCImRRfdM5GsGkTYgJQhmAZCPtbP
	77dIL1YpiFnBrcQ/EbrRsKkN1SuHRr7QA7nKL2upu7PoDbHPA4dgbtvMtVjNlBRYS3iBZNpYjG7
	+g6Ko83UCDrk9MH6v
X-Google-Smtp-Source: AGHT+IFAI234bDkyXXIeNHpEbB1U8Jccu6tTIQixfwy1mCNddafRlvmQYFCshie4oRvFllieoeJfMg==
X-Received: by 2002:a05:600c:420b:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-43d1806c066mr51117445e9.6.1741944763036;
        Fri, 14 Mar 2025 02:32:43 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a80sm5030639f8f.61.2025.03.14.02.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:32:42 -0700 (PDT)
Message-ID: <16fa84a264428b26c1d9e848270b87bf21c7fe8a.camel@gmail.com>
Subject: Re: [PATCH 06/18] mfd: adp5585: add support for adp5589
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: kernel test robot <lkp@intel.com>, Nuno =?ISO-8859-1?Q?S=E1?= via B4
 Relay <devnull+nuno.sa.analog.com@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Lee Jones <lee@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <ukleinek@kernel.org>,  Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov	 <dmitry.torokhov@gmail.com>,
 Laurent Pinchart	 <laurent.pinchart@ideasonboard.com>, Liu Ying
 <victor.liu@nxp.com>
Date: Fri, 14 Mar 2025 09:32:48 +0000
In-Reply-To: <202503141715.1e4xyKyq-lkp@intel.com>
References: <20250313-dev-adp5589-fw-v1-6-20e80d4bd4ea@analog.com>
	 <202503141715.1e4xyKyq-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-14 at 17:23 +0800, kernel test robot wrote:
> Hi Nuno,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on 4d395cb071a343196ca524d3694790f06978fe91]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Nuno-S-via-B4-Relay/dt-bin=
dings-mfd-adp5585-ease-on-the-required-properties/20250313-222511
> base:=C2=A0=C2=A0 4d395cb071a343196ca524d3694790f06978fe91
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-6-20e80d4bd4ea%40ana=
log.com
> patch subject: [PATCH 06/18] mfd: adp5585: add support for adp5589
> config: s390-randconfig-001-20250314
> (https://download.01.org/0day-ci/archive/20250314/202503141715.1e4xyKyq-l=
kp@in
> tel.com/config)
> compiler: s390-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20250314/202503141715.1e4xyKyq-l=
kp@in
> tel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion
> of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202503141715.1e4xyKyq-lkp@intel.c=
om/
>=20
> All warnings (new ones prefixed by >>):
>=20
> > > drivers/mfd/adp5585.c:249:34: warning: 'adp5585_02_info' defined but =
not
> > > used [-Wunused-const-variable=3D]
> =C2=A0=C2=A0=C2=A0=C2=A0 249 | static const struct adp5585_info adp5585_0=
2_info =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~
> > > drivers/mfd/adp5585.c:239:34: warning: 'adp5585_01_info' defined but =
not
> > > used [-Wunused-const-variable=3D]
> =C2=A0=C2=A0=C2=A0=C2=A0 239 | static const struct adp5585_info adp5585_0=
1_info =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~
> > > drivers/mfd/adp5585.c:229:34: warning: 'adp5585_info' defined but not=
 used
> > > [-Wunused-const-variable=3D]
> =C2=A0=C2=A0=C2=A0=C2=A0 229 | static const struct adp5585_info adp5585_i=
nfo =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~
> > > drivers/mfd/adp5585.c:48:41: warning: 'adp5589_volatile_regs' defined=
 but
> > > not used [-Wunused-const-variable=3D]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 48 | static const struct regmap_access_tab=
le adp5589_volatile_regs =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~=
~~~~~~~~~~~~~~~~
>=20

ouchhh!!!

will fix in v2

- Nuno S=C3=A1
>=20
> vim +/adp5585_02_info +249 drivers/mfd/adp5585.c
>=20
> =C2=A0=C2=A0 228=09
> =C2=A0> 229	static const struct adp5585_info adp5585_info =3D {
> =C2=A0=C2=A0 230		.adp5585_devs =3D adp5585_devs,
> =C2=A0=C2=A0 231		.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGM=
AP_00],
> =C2=A0=C2=A0 232		.n_devs =3D ARRAY_SIZE(adp5585_devs),
> =C2=A0=C2=A0 233		.id =3D ADP5585_MAN_ID_VALUE,
> =C2=A0=C2=A0 234		.regs =3D &adp5585_regs,
> =C2=A0=C2=A0 235		.max_rows =3D ADP5585_MAX_ROW_NUM,
> =C2=A0=C2=A0 236		.max_cols =3D ADP5585_MAX_COL_NUM,
> =C2=A0=C2=A0 237	};
> =C2=A0=C2=A0 238=09
> =C2=A0> 239	static const struct adp5585_info adp5585_01_info =3D {
> =C2=A0=C2=A0 240		.adp5585_devs =3D adp5585_devs,
> =C2=A0=C2=A0 241		.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGM=
AP_00],
> =C2=A0=C2=A0 242		.n_devs =3D ARRAY_SIZE(adp5585_devs),
> =C2=A0=C2=A0 243		.id =3D ADP5585_MAN_ID_VALUE,
> =C2=A0=C2=A0 244		.regs =3D &adp5585_regs,
> =C2=A0=C2=A0 245		.max_rows =3D ADP5585_MAX_ROW_NUM,
> =C2=A0=C2=A0 246		.max_cols =3D ADP5585_MAX_COL_NUM,
> =C2=A0=C2=A0 247	};
> =C2=A0=C2=A0 248=09
> =C2=A0> 249	static const struct adp5585_info adp5585_02_info =3D {
> =C2=A0=C2=A0 250		.adp5585_devs =3D adp5585_devs,
> =C2=A0=C2=A0 251		.regmap_config =3D &adp5585_regmap_configs[ADP5585_REGM=
AP_02],
> =C2=A0=C2=A0 252		.n_devs =3D ARRAY_SIZE(adp5585_devs),
> =C2=A0=C2=A0 253		.id =3D ADP5585_MAN_ID_VALUE,
> =C2=A0=C2=A0 254		.regs =3D &adp5585_regs,
> =C2=A0=C2=A0 255		.max_rows =3D ADP5585_MAX_ROW_NUM,
> =C2=A0=C2=A0 256		.max_cols =3D ADP5585_MAX_COL_NUM,
> =C2=A0=C2=A0 257	};
> =C2=A0=C2=A0 258=09
>=20


