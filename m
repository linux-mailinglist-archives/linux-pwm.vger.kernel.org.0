Return-Path: <linux-pwm+bounces-3542-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035109953E9
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0741286EB8
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D11E0B6F;
	Tue,  8 Oct 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTC8A38+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982021DFE00;
	Tue,  8 Oct 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403166; cv=none; b=IC4ceXM13DB/et5zL8sKQSZCgjohqintKbLSeugOZnetXq8DYZ3o3jzMR/HC/saZxEkAlczjp+ZcZ8WAS2Omh2dH8LjSggApDLVxoO+nYx3IPgiO39F3hmiu54ofkIPvBt20f85WpVFhVRoAggs8um8MY6aAtiaTSekj85cosMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403166; c=relaxed/simple;
	bh=6DJwM/LnvjD9C2bnMM/ha1h2dbvHNieWsmvJMPgzlV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfTIz424MG8aTEc7Z8QHHlXhSjNrPziNcOL4zwAhPVHG7dDcBISjnrtO0BF2b4rl1a5fyR6A48ATUeIidyyOpTeAjouSCcnIgcGJ7DLI23h0J24A0s1N4lo1bJP31+AAlH8Dv6rNkTmC672QbPtjI3R9UEVqTBkp1FXQGIv8WBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTC8A38+; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53997328633so7718819e87.3;
        Tue, 08 Oct 2024 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728403163; x=1729007963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzYpjetz4XROYOG9r48tBi9Okr5Oaql6hR8lKZwZDY8=;
        b=gTC8A38+wp92mBFXJJDJikLZuVn26mlARz7xEDnS3WZvuvaNI/7JeG5X2CVoT2xzR9
         tdee8BEMd578YxbXfblTpFXiZ6K9HMoVEYYA+k9m1THzZ3cpcioUCdY5Qil7gqZQvZ2W
         9H9+Z6gOBOmGKrJiURlRHb5FQZ9vYlJw8oOjpVjuPWcX1fZcMcOxd08FqVFwaMz7+BSB
         pLFwIN3jrJGXHQmhySORoGmhOS8WaxVb3Kkb3/S4GPH11nTJ8mTyfhU77/h0vb5XnAMS
         4ZRVX9GejE76OF6Nsm59Lqh3fntVBqDHZnwNaVLURsRWYRyzKrQK9BP8wNWLkLlsa1nu
         PGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403163; x=1729007963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzYpjetz4XROYOG9r48tBi9Okr5Oaql6hR8lKZwZDY8=;
        b=l2s6OXPFeE7bfKS7VlWB4kImg/6o2AbfhZQQdWJSZZTTctXOOoXwpJaBivGi0LUPxt
         JCZFKrl5m5eANpCrvD5sFsQPmcebTqs3739pjucsmIuDWBdqJT29a3eoNGDB5HMYSeLe
         eRy8p9cDE9IWKRi+wuAq3KdtiETdAQKI90m9bKEq/sFxWyFzDQ6Aazp+4dwoEolqOYho
         Ns6bWGioEnw47cZZVjzSufPm5fu0cxgO+wCVKHPWxc0exdNe0fd3C/scJ7Nd7wK0iMWB
         q2HVn3kgZJG9V+dxU1PYDI1FwKCs1NYxCB9dBCIq6eawr0ffD5cstgCPmqrKXUZZ2LJa
         8Ubg==
X-Forwarded-Encrypted: i=1; AJvYcCUdBc2xoJT6C97cQawPpb3EwjhuK0ivUFcuRe02NMMA5h0lp47UKjv7bqgmbR4huTyQ2E79ERHmgDVm@vger.kernel.org, AJvYcCV/X7d9q3hnqW9fPVH6yx+UfinGqQ5l2p+Ts57FwRfc5FOwnwb9wb9wd0rJ4nMj5N8OOlc5j2v+Ff5h@vger.kernel.org, AJvYcCVJFQTpc3x63NYVkmL5bzFEojv21bY4H1R+rfnIEMnG0gC4bR1gy4yWT42rXdQ2U7HgwgRHqMgavSno@vger.kernel.org, AJvYcCWSJ9jn/im1gyBKjyUYDIim752r9qwQB637KJ/IWqmRVGXQcLGamSSdkSdgbKpNwYa7bafU4CcbrjTTeOxY@vger.kernel.org
X-Gm-Message-State: AOJu0YzuwQFsNIkbQ7NZLasY0H4f5DG+RFH7fZ1ejSUOmVWrJWBQXQt5
	Cbt5nk5QX/cEZeueZz1Q0h57AZ+EB1IQRSUzoXXb0cO+jw7UnWUo7MkIa6dKvecSzMJ3Nqbg/hd
	BOJo72SGsF9s9G+sGG/ldaWBrtBU=
X-Google-Smtp-Source: AGHT+IF8PajqB+hvsPzsTQ4JpQY64kIdB3uepGNXxpTbt6Zi8IofIi4esCHWPwV/vDgQcbEfUK5ajoGDuZ4pNFghfp8=
X-Received: by 2002:a05:6512:b29:b0:530:ab68:25c5 with SMTP id
 2adb3069b0e04-539ab84e022mr10495835e87.2.1728403162256; Tue, 08 Oct 2024
 08:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-6-antoniu.miclaus@analog.com> <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
 <CY4PR03MB3399684E3021A1261DC5195B9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
In-Reply-To: <CY4PR03MB3399684E3021A1261DC5195B9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 8 Oct 2024 18:58:46 +0300
Message-ID: <CAHp75Ve1SgiY3dRuET=9icvy7W6kmZukbNcG1B0Le6+qKaB0JQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Sa, Nuno" <Nuno.Sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	"Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>, Mike Looijmans <mike.looijmans@topic.nl>, 
	Marius Cristea <marius.cristea@microchip.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alisa-Dariana Roman <alisadariana@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>, 
	"Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>, "Bogdan, Dragos" <Dragos.Bogdan@analog.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:37=E2=80=AFPM Miclaus, Antoniu
<Antoniu.Miclaus@analog.com> wrote:

...

> > > +       bool pn_status[AD485X_MAX_LANES][AD485X_MAX_IODELAY];
> >
> > Why bool and not bitmap? I think I already asked this, but I don't
> > remember what you answered.
>
> Both ` iio_backend_chan_status` and `ad4851_find_opt` require bool as
> input parameter.

test_bit() and family returns bool. So, what's the issue with that?

--=20
With Best Regards,
Andy Shevchenko

