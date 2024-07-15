Return-Path: <linux-pwm+bounces-2822-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97111931C2D
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 22:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E551C2181A
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C213B58E;
	Mon, 15 Jul 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHa5vIWE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC1EAE7;
	Mon, 15 Jul 2024 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721076365; cv=none; b=h5v9cHEEX37flV2iRMF0mWFC2/qiNWp8EP4i9guNqy6OMU89jW2yGOumWR3OD/Nz8D2qaIKd6+aBQrpnpq474Y5JT1ldoUe0/QAVKZxbDN1/nvbcfTzEzNqrb+wLot2oARJIHkwosRrdqdI9D00TFkFrWtZVsxo0yaB4RLfbquE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721076365; c=relaxed/simple;
	bh=pyID40vVKswGidkaN4WhWHKgSgKubU8Ytrc3zgyQIzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+xGZLW1nLRyppQT2B46yP+WvImzzRJmVOXTGZytcuym8DVwcVYqI7o/P3rEt7O3GDFBeZg5esJxZ6RZtz9F2yes4S02qWexitfEi0wA8ywEo/BOt90g8tVI6lGajAM1YIQ8jRE159vWcswtL1VTpd+fz3eVfJzGpFh4TBuaeqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHa5vIWE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso5254040a12.2;
        Mon, 15 Jul 2024 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721076362; x=1721681162; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pyID40vVKswGidkaN4WhWHKgSgKubU8Ytrc3zgyQIzA=;
        b=OHa5vIWEXxzyHXKqqoP9PYQGzYD1ecRI/3e3snuws82NE5UQ79FDYiB/pOHuiFPryN
         MJYQYmy3Fh10xZDsajNlYCb4uFRq+/ufS8OoqSCBSVEpjhWGmWsfp54l/NkeQOnUs0I1
         ShtJjTZEkLzihUVDf002/0WL9hMbECeuQumMgP69HCs8XvgmZyHO66k8TQHTxkj5yIFN
         PTynY1OR4ZDo5NmLEqoxL65LdFXubh1mI1MreZxz/N0bvxnLCeL6MQ7U8lcmwpv8Og+k
         5cYokb2ui3eOAxRfp3zq3TfbVFthC/El3qfCBZ436XLoGhJZWLpGpmymw8BxBYalKnoV
         C+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721076362; x=1721681162;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pyID40vVKswGidkaN4WhWHKgSgKubU8Ytrc3zgyQIzA=;
        b=BJTkvlJfhF5RoHAzc0IN07daqmw6waORavq/QAIuxHJAWEwm4ZZGT+mAAMo/lnuN9W
         6WAWpNWgDySogFKpUn4tEs/z0sSIAwYlm9Jmjn9ltDUX6+njQF3eYks5ESD+p1vVicw1
         DkKTY6rumpF6BUIqk2Icv+Dyia1foggmiV4YMSrJ9BgFY8y56t5K3mNNo4NuK6p3Ibiu
         zUGNCgJlubuE98LStBpR9XHzBTgOWoGPxZZm3vRADpznOekTd7YY35f0vWrxnXi2fCbJ
         Fy2n57VBU5IE1LMAupL1dPgg0Yu5iw1M9DI9A2KvQ8ZuY2uCYufcqEZ00P8fKFrRbe+y
         IXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCURrBDqXuvgwdXyss97WSuG+2fN/jyDhB1oz554i1TvIpKykLIGO6JWaAI5JLW/EpOg8rd+itZCraMb/qQEtOLBXmUSgipXmY8XpZZoF9DuCUWqpRIKMs0H49zH1UQ5f3+c1f0V+EwT1Ux0xGCy++1SNo1PH4/1ojXqvmGGN8EXv824dvsYnB72I5EHt57qKU6czdBF9FucP80r9k6s4HgliJxmkJvtyy+Jp79D4Qevcak/w/lB5ltsm/eG7cVYe9tEmvadZkzNuaQJjV4M7Hs0Q7VsMRn11dFOv4prJ32iNpb/8FXu7LVXfKt0gRICRLM0qbLK/lXritMwxEdXnLWEK37bHNiVjbs/Hh14g+s/crg1LA==
X-Gm-Message-State: AOJu0YwiKRFm/IaULVCU9XP7Xe/x3ucRvUmIXSbh73mZKkpgml0E8NeR
	V9BOe5HiGLPVvOPydB8aWyo3LBES7z9b72TjC/5Z3Tm/4Y1WWUuu
X-Google-Smtp-Source: AGHT+IHZpaZWcXFCjRZBArLC0Q4QIJCZB151JdU+pruJeqzfFvKL2FYuoiEW53znBItBXa8q8c0m1w==
X-Received: by 2002:a05:6402:270b:b0:59a:aa54:4e23 with SMTP id 4fb4d7f45d1cf-59eee833f0amr46280a12.3.1721076362036;
        Mon, 15 Jul 2024 13:46:02 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:860a:c700:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a770dbsm3829880a12.4.2024.07.15.13.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:46:01 -0700 (PDT)
Message-ID: <f68b628c3978a4fb0e5989e3b6918c756da1fefb.camel@gmail.com>
Subject: Re: [PATCH v11 00/38] ep93xx device tree conversion
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Nikita Shubin
	 <nikita.shubin@maquefel.me>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Damien Le Moal
 <dlemoal@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry
 Reding <thierry.reding@gmail.com>,  Vignesh Raghavendra <vigneshr@ti.com>,
 linux-pwm@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Ralf Baechle <ralf@linux-mips.org>, 
 Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  linux-ide@vger.kernel.org, Stephen
 Boyd <sboyd@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, linux-spi@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown
 <broonie@kernel.org>,  Hartley Sweeten <hsweeten@visionengravers.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,  Andrew Lunn
 <andrew@lunn.ch>, Richard Weinberger <richard@nod.at>, Eric Dumazet
 <edumazet@google.com>,  linux-sound@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>,  linux-input@vger.kernel.org, Jaroslav Kysela
 <perex@perex.cz>, Sergey Shtylyov <s.shtylyov@omp.ru>, Lukasz Majewski
 <lukma@denx.de>
Date: Mon, 15 Jul 2024 22:46:01 +0200
In-Reply-To: <172104541245.3725513.13547524352291855487.robh@kernel.org>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me>
	 <172104541245.3725513.13547524352291855487.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rob,

On Mon, 2024-07-15 at 06:12 -0600, Rob Herring (Arm) wrote:
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
> =C2=A0 pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy cirrus/ep93xx-bk3.dtb cirrus/ep=
93xx-edb9302.dtb cirrus/ep93xx-ts7250.dtb' for 20240715-ep93xx-v11-0-4e924e=
fda795@maquefel.me:
>=20
> arch/arm/boot/dts/cirrus/ep93xx-edb9302.dtb: /soc/spi@808a0000/codec@0: f=
ailed to match any schema with compatible: ['cirrus,cs4271']

well, this seems to come from the fact is still documented in a .txt file
(Documentation/devicetree/bindings/sound/cs4271.txt), which is not really
the scope of this series. Hope it's OK to ignore it for the series.

--=20
Alexander Sverdlin.


