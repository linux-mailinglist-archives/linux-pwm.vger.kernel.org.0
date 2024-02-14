Return-Path: <linux-pwm+bounces-1499-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E259A854DBE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 17:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FFE1F20F1A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9F15D756;
	Wed, 14 Feb 2024 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ae0n2h3z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33506024E;
	Wed, 14 Feb 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927027; cv=none; b=PqMDdarZVFqU0FnDJMNPvFS5/TtOTCakDM5AgeM7IbB6J/e+Dw+qxDejdWDB18gcpv/Ns7mD0EkrhcGORt+qeI5yUNqItgAPFQYXd346lwJNohpRyz4UNIb+UnOHUhD68mvebDhj25Z3B1cZZWUOuT/4sKCImk8T6WmiHUaZFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927027; c=relaxed/simple;
	bh=EPePPB/lIurC0Ku/0gWbLOnLCawKF9APUfhsaLua0Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxvKyW8NPKoEKK/Dgrw0ezcK5Iuz8BiycavhS3sC3F6aMIp4w/eNX9/SjmpG59vBHFYamDdIbMxYYo3alYQra3HatOVFUHnEJqdosx2cWQ59S9VNmMYFgsN3+39sfrFAnedl+dcurvT4FIKjm2AHlJCTLltzcjLJnAyIEuoTU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ae0n2h3z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55fcceb5f34so6733347a12.3;
        Wed, 14 Feb 2024 08:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707927024; x=1708531824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPePPB/lIurC0Ku/0gWbLOnLCawKF9APUfhsaLua0Kw=;
        b=ae0n2h3zxyuMoEeQkaguWMagG+AvESE1PP3VdfmWi9dcu3yFgIVvZk426w7wzhqC5l
         r7wjojZTq9vskb/r86YMT6isbnC791n/3y/SHyIkGtnwubsPWfanHWJz1oiNti6jDj9e
         exIuMidWlqcXzP47NBy+KbzyNx0+S7OAlZTCH+FfbQUEHhE2OoGmZIJnz3jiD26HOjfB
         zsGfyOksxw+0uTsjreZcYyh3yszjpa4xsytpYKOZ1lgRgm11qLRVI44x9TvcVPQuI+r0
         MsLtmxshxyQwKUvUb1+2/HhVDgMZaRHqwwwM8F/Ttfp+GkDhuLJwAkQmqQrFJ5bFgzWu
         WHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927024; x=1708531824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPePPB/lIurC0Ku/0gWbLOnLCawKF9APUfhsaLua0Kw=;
        b=HBpQxAlFgmOZSYL/DuAc5pY0PiRaRwV7PO1I62HMntgrXMx/I5+koroCXwQ0N21NW0
         QJwnPWmdLuQu8i1SgUpkZDRCPS8EzMeHGa1zHAWpSwy5Xx6ke5HNhdmHt47HhIikO1S6
         FL09zVBwjd6IG08lXtU42/yM+acAraBLuHuDuVWkjirkzHQ3vIGKuQt7S5aDOnUEyxtr
         Tp9XeFQNV+fY9l+E6aLLkFbyXyN5rnJk4lbO3xwYtiOjMde2vVGnO2ehA+/6c/csWVmc
         v+Gf4OcmBeDyAsOvvYym6eFzpI7EauD7/DBAOM7SMP5iOHfp8DHChVX5m3kL0dcuMdEq
         hqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt5t5dz8bTPNL6Se/C1c5QC5DYB8E1Bc8RkNtBVBBalksUEN9ki/a8VKaMGOI24hnFfiUWzzM7iu/Wybvqc8FG1tgkMGEJtfvrdRkrb5DbYopDMxaAXWjgCSTDxrP6mhQldlSZJYa31zc7wv20GILeEePePjv+I028ejSF14vqTgcWEq5qtjr/EOc=
X-Gm-Message-State: AOJu0YwTCwpoze6xzK8N+Gn/RxbuHmxIR9oMCBcA8qifactLtxodBJfo
	gI40F6wFb6bvsENllRWBRbIrvtKW/qHKprCGjSxAnWNwXf7fFz7SIQEZ7bZjkX6M9zDjnebRZA1
	RzEd7BG8YtPfc7w741yF+F7OXiFE=
X-Google-Smtp-Source: AGHT+IELyJJh2ZRqPQwjBq0JI6m6ylIDhOzbOF/1/4Ik5wJAvGSCRU/schLL2+qkq5hr3L+hrhhH/uwyjCTF0Nw/sPI=
X-Received: by 2002:a17:906:aacd:b0:a3d:4bf8:124a with SMTP id
 kt13-20020a170906aacd00b00a3d4bf8124amr1544407ejb.35.1707927024008; Wed, 14
 Feb 2024 08:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <b567ab5dd992e361eb884fa6c2cac11be9c7dde3.1707900770.git.u.kleine-koenig@pengutronix.de>
 <Zcy2GbkjX7N6buB9@smile.fi.intel.com> <asyro4yemnlljhyjxk7dxzzo3nlhqxq7hg5vk7lirx6gtknqsh@4jd42jhr6bkp>
In-Reply-To: <asyro4yemnlljhyjxk7dxzzo3nlhqxq7hg5vk7lirx6gtknqsh@4jd42jhr6bkp>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2024 18:09:47 +0200
Message-ID: <CAHp75VffQUet_ZiE4-e-DzjzxMoNM8L=0WQiommi=hc1Hr9sxg@mail.gmail.com>
Subject: Re: [PATCH v6 067/164] pwm: lpss-*: Make use of devm_pwmchip_alloc() function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, platform-driver-x86@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, kernel@pengutronix.de, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 6:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Feb 14, 2024 at 02:46:17PM +0200, Andy Shevchenko wrote:

> (i.e. I didn't add your Reviewed-by tag because I didn't capitalize
> pwm).

Are you expecting me to bikeshed?! :-)
Please, add it there.

--=20
With Best Regards,
Andy Shevchenko

