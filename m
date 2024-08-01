Return-Path: <linux-pwm+bounces-2959-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528269454DF
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Aug 2024 01:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083E81F232A8
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E946914D2B3;
	Thu,  1 Aug 2024 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgJBxrfm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFE14B94F;
	Thu,  1 Aug 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722554510; cv=none; b=JDxKJFwgXy6NGazZSsMdfTandtNODP5d7xclwxIat9GuL7VzPhR2d4uFvfjhaShQUC50iTDQx0v0sEJclnbqxppaSrFR8d1i6+6RVWfXICO4VbESyRq4JjARV/waUFdmykY+5myGAS/I4vCxSAJrXcqTvQxhd2ZEAN1WrorEOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722554510; c=relaxed/simple;
	bh=psyqP/Yl+Il9HAgAySc9C3R3e0Ms2wPZSoZqeFsjuME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvQWRuW1UHMOw+Mws1E4IxhRzTZqVq8ZrV1s6BVJvwIR5ZDwVeFPMbX6dDc5XUZ0JlgRVn7K/vdySKse53lW8lmCm8c+M4/ivpNnkJh0Cp6CZuanKIgIJF0/OC7LidYhQ3Do2S2YiroC+b468Gic+kKh1aiaA+WmzX0UN9dgk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgJBxrfm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so977572266b.1;
        Thu, 01 Aug 2024 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722554507; x=1723159307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psyqP/Yl+Il9HAgAySc9C3R3e0Ms2wPZSoZqeFsjuME=;
        b=CgJBxrfm3gAIXCzd+b/M8hdCW5PHzqmMiGVdeZXT1wdMg9YOz+E/g3IiiuWa1rHunc
         iad8ieOpxhtm7PmkZ96VvOAjWkZBSBUWYogQj7DxyevSv++ih3/MFpt42uZTaRFYWm53
         E0gjlpQFvBzi1zTECiuEpJmomVdUoMN/yz9TNqi/HfxlqMdjkLFH5OFlWoUt0scfXekS
         23qrpHYiKmFZ/3FuXE2GWKM2379OsLHRu3ykgw3RRYmfszh6mQifCc0S6uaWaS+EzEFP
         nydNrh3bu2BtM+EOtO5rlqEeRbtnMMx8fdAZNWjAurPgHeRV+hMG0/tsdWTTUSVjO217
         U6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722554507; x=1723159307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psyqP/Yl+Il9HAgAySc9C3R3e0Ms2wPZSoZqeFsjuME=;
        b=Hv4RAPANqUffAKMLtornXnPic1mgkivMdhTtKEweJ3jSbjt7wpGAMvj1gmjQl+OdJi
         oOr3m2GXSlXcqLxsdNsOyYUzbOpecQdnKKzMuxo+f803nioORZAziUC9XjNFqLgekhFx
         eui7UM5UsObEsB8H0CfO/fSjQ9fyknVPxYQp11ZZzMDZ9DCZySfavFfuDq+dWm6hxzmy
         xoQFwjma29q6s+EEb/6mhT3FA3lglhtUkf1+1BsXdVoCuyTKWCXSdwjQvw6EjU/Oo7wa
         1qW+YmAHwnmKuStwjhGgfpGZVgVh03IreiYwpu5lWqLtWNUP7M5q2YpCFuZ488U9R4wD
         u4mA==
X-Forwarded-Encrypted: i=1; AJvYcCXsbLnOBCipPX5vxFDedz8QYAEa4znCmAa9DVKJ2ExqchdpnrmwM/OuDx142hC6uyeiEHhQw7bTJNZsKne9mJV7MSsIlDFFwneQkC/Q3PZ14wk6/H0SZg9DKRtycKT7PLX8aiY7ZtjDhtVVusa1HpD7wJPEHiLLTuKDMsR1k10vPck=
X-Gm-Message-State: AOJu0YyStV9p/S+OP6odA0u6DHuNzs4j2sbGEfnA35ZZcUY+AU2QsHcf
	eKOQmuO7jwE5RgqHevtm4zEgteA2xvRvcDrXkhVB6yiR9XHPOuZ0qF5Pv1axQkxYIiORsMQoQNp
	vnbIufiZb3MfNPYrrOrloFsPjpr8=
X-Google-Smtp-Source: AGHT+IEtW/qBmI51B7Hfnj94oHwwxVZCxxaiTaEWAE6CvzL5fsAvEqIpySGzx598UrGchK7/EuMJsVWked05rpwf+Pc=
X-Received: by 2002:a17:907:8692:b0:a7a:9a78:4b59 with SMTP id
 a640c23a62f3a-a7dc4e579f9mr116053766b.23.1722554507307; Thu, 01 Aug 2024
 16:21:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-5-laurent.pinchart@ideasonboard.com> <ZmcWi08u6-u4MyKu@surfacebook.localdomain>
 <20240610152833.GW18479@pendragon.ideasonboard.com> <CAHp75VfcTHty-Vzcc+B4iMk33qS_AafvU10Qn3AQftrfQRBebw@mail.gmail.com>
 <20240719140711.GC637@pendragon.ideasonboard.com>
In-Reply-To: <20240719140711.GC637@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 2 Aug 2024 01:21:10 +0200
Message-ID: <CAHp75VfK0pae+OugD8=5zAhbjw73+mw_uvj-x=_3W9AMWPhNTA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans De Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Clark Wang <xiaoning.wang@nxp.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 4:07=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Andy,
>
> (CC'ing Mark)
>
> On Mon, Jun 10, 2024 at 07:31:11PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 10, 2024 at 6:28=E2=80=AFPM Laurent Pinchart wrote:
> > > On Mon, Jun 10, 2024 at 06:06:51PM +0300, Andy Shevchenko wrote:
> > > > Sat, Jun 08, 2024 at 05:16:33PM +0300, Laurent Pinchart kirjoitti:
> >
> > ...
> >
> > > Andy, we're reaching a level of nitpicking and yakshaving that even I
> > > can't deal with. I will have to simply ignore the comments I disagree
> > > with.
> >
> > Do you think using bulk APIs is nit-picking?
>
> In this case I do. If we were dealing with more 16-bit registers in this
> driver I would agree with you. This being said, I'd like to get this
> driver merged, and I'll burn some of the mental energy I've recovered
> thanks to the last two weeks of holidays and submit a v5 using the bulk
> API. It's getting mentally exhausting though.

OK.

> Overall, I think it would be nice to improve support for variable-length
> register maps, in a similar way as done in include/media/v4l2-cci.h.
> This driver, as well as many other drivers, could really benefit from
> it. Mark, do you have an opinion, is v4l2-cci something that we could
> fold in regmap itself ?

+Cc: Hans as he might have even considered this (I'm speculating, but
considering his quite a wide involvement in v4l2 sensor drivers and
drivers that use regmap this idea might have come).

--=20
With Best Regards,
Andy Shevchenko

