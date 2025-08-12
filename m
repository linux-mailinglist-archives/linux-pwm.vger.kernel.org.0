Return-Path: <linux-pwm+bounces-7021-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F67B22601
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0AA2A6560
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD352EB5D5;
	Tue, 12 Aug 2025 11:38:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A72C2EB5C7;
	Tue, 12 Aug 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998690; cv=none; b=tB3tSGeLydSmPtmAb5mzGsMfqVQyq5qJ0mRwYbsDMSqNifsFwmrzBTdgNI9F3llI57bykHEsLZCcssViTc+vUM7aTSWxLA3BkxfWpRF+W2zmN0NcyZ9JcQIfDkstlX2NK3XSEyehk0ZfP5AfukXE1M2/9Sm/ECeojYV8xgwI5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998690; c=relaxed/simple;
	bh=w4Okp2vqbeOHnwzraNE9RYXZ4qgaoN/u3iuePL+3Ddc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcTwM5obyLDYFbeFtd819F71a3f8s38Cuaa+jLBgE6Ds2qbRjowU07Syr1tDfUEhFmYlu5vER7NrbwyRJErIJ2DeZvy6eQFuYWEoAsg+l5T1QBlCsUOV1JY9uqNxcdw/naJl/TsjM3ZeukoPUqhOulyRc9feYBv1VB3csM1GJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-500006b3efdso4896603137.1;
        Tue, 12 Aug 2025 04:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754998687; x=1755603487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Am/i9gJ56QhlGGBrTKvZRFDN8RKSA6du4RdJCjyJ/PU=;
        b=ittW/yU9wrnbx/eJP7WX83vIORQsKIqY+xjJCLsol7yOJ/ZtGZQ2t4t0m/6aN43vdv
         nULquJAIwuJJBGm24ZWWLHxTlvI2tPalUV3ZboNEkIgWThFZNKArw5ggYmnYmxkzI90f
         LuXsyPFSktVRIfslykXZ5iiHzc5vJBrCv6B4P4JH3VXq4Tiu13ZjxRDCf7i32fDmZVPb
         UepWlBir15l2D6dx7gzWhD2WreAwjluuf/SWNDiqspe2juC7AZt/7UuciQMz0lSAOk5o
         ggXwSKHQlm8K+AQDslNZPJnisBWrnRcCYRdyjWSO0dMPFBHD0jfIEagIuKhcblO/209m
         pH8w==
X-Forwarded-Encrypted: i=1; AJvYcCUJoNNC0Ot551SeycOmaAkxYy/52UPU4telknGEup3OzIv+EGMhKeYbkIaMjil6FK2jUiKPa1oMSbQg@vger.kernel.org, AJvYcCUkH15ZvvKpPW3deg7whS8pqOZy4SXxRjwxzHrsfT5ijVTe8CNSQtD20FnpYTagDqY2nA+2irY6vJn3@vger.kernel.org, AJvYcCXpUBj5inIl0SKuG+ZXA3Dc9U5xKjgtiEW8t/ZNvdaYniPEXExB0DmcZU/miAyy0A4AYrbE5XU0thviC6xO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WSF+PmWHJ9hlGrJYc+hquw1qX4OmPOYXWBgbLrYvkjOuyzHr
	9i8x985CAnMu2Y3aMWQvt7J6rymd59QwLpm+dlCmCRhCGhOAZz/rIJ9aX5CG4B9G
X-Gm-Gg: ASbGncs4D+LHA6s39MYNL4xwqRmY+sTA5BHIMHjxKq4hJnEPOa040G37cwO4SDVQedI
	7/HtfeJxa4kN727IAViQe8tQ5OlokKkmroHtuvj7+PDRjMoZDXWjjWw3v8LYBMG1O4K8hLvcL0N
	g2kLoVRDQjf57cA6eW8eAWCq9hiBOV2dNuqH/jjhT4dU4GaE2JhFtv7XUZFCf1XxdfSoI+o1nfg
	7xkxIjMcyCWc1jNEauVHPZd1OYJsY/EriESc160jtV8JI9XB9loSfkA17A4ZVQ9yT6gu0Hb4okQ
	yKxlM4A53D9NEPagD1LDmacINTWMS27sBEL1NMqpVe2qmRTPOgtvPxjqePqf642B2ccSvCrEtnt
	EdUStUPM64EkhStJ8v96cjbmglikoB268yu4r9YJjNl+fPoa6wqpT4MHq4/pW4fKDzAbPQlA=
X-Google-Smtp-Source: AGHT+IFrA7DrI3lpPSPbAExAZt6D1APqqnXIG+OUjVGBFUBwYZajjfwv3kKRIJYUQBVCNTI8Eo3w+Q==
X-Received: by 2002:a05:6102:3e1b:b0:4e6:443d:9b1a with SMTP id ada2fe7eead31-50cbee69bf7mr1507469137.24.1754998686894;
        Tue, 12 Aug 2025 04:38:06 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e0268d452sm2194418241.5.2025.08.12.04.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 04:38:06 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-88bc87958d3so2516993241.0;
        Tue, 12 Aug 2025 04:38:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9rQfzyH+huo9EmlJnVCZkahHC2ZPN5qIXSM37Ge9bgfjfT2kwAlxa+mTUdA4TERsld3IM8eJ4GxqJ@vger.kernel.org, AJvYcCVui5v4bC2g+RfCDZdq7Skf2cqINI/tgoxL9WR+pPVPw4F9ht3SREreEgkjmO77Qr5HNM+R6yvn0eY9@vger.kernel.org, AJvYcCXrvDz3ZlmCSC1Ve0ntfYSX1DMmDhYscfPdC6I6V4mTgR7Djpa83AZeVJshw4VkXsypqNHBUCsL0r7D0Kn+@vger.kernel.org
X-Received: by 2002:a05:6102:3594:b0:4c3:64bd:93ba with SMTP id
 ada2fe7eead31-50cbd1e1ee2mr1421381137.11.1754998685794; Tue, 12 Aug 2025
 04:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5366fcd01c9f8b374914e6137f01d156033c8a9e.1754986373.git.geert+renesas@glider.be>
 <z7wqrfqvx5rtm6ztvwnb4po5dvabgb2lyse6nws6ojzjdr6k3e@qzpopioosaai>
In-Reply-To: <z7wqrfqvx5rtm6ztvwnb4po5dvabgb2lyse6nws6ojzjdr6k3e@qzpopioosaai>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Aug 2025 13:37:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDy5ZtDBYkkVOWE4C=h3L85+R6HFzY1fYt51uDCG2-mg@mail.gmail.com>
X-Gm-Features: Ac12FXwHP-2ivaSJEo1Z8tczA_UaeK9I-9xB-dON_4HXW7qtJ7lIzB5Od4FdiBA
Message-ID: <CAMuHMdUDy5ZtDBYkkVOWE4C=h3L85+R6HFzY1fYt51uDCG2-mg@mail.gmail.com>
Subject: Re: [PATCH] pwm: Rename GPIO set_rv callback back to its original name
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-pwm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, 12 Aug 2025 at 12:44, Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org> w=
rote:
> On Tue, Aug 12, 2025 at 10:14:59AM +0200, Geert Uytterhoeven wrote:
> > As of commit d9d87d90cc0b10cd ("treewide: rename GPIO set callbacks bac=
k
> > to their original names"), the .set_rv() callback no longer exists:
> >
> >     drivers/pwm/core.c: In function =E2=80=98__pwmchip_add=E2=80=99:
> >     drivers/pwm/core.c:2514:26: error: =E2=80=98struct gpio_chip=E2=80=
=99 has no member named =E2=80=98set_rv=E2=80=99
> >      2514 |                         .set_rv =3D pwm_gpio_set,
> >         |                          ^~~~~~
> >     drivers/pwm/core.c:2514:35: error: initialization of =E2=80=98int (=
*)(struct gpio_chip *, unsigned int)=E2=80=99 from incompatible pointer typ=
e =E2=80=98int (*)(struct gpio_chip *, unsigned int,  int)=E2=80=99 [-Werro=
r=3Dincompatible-pointer-types]
> >      2514 |                         .set_rv =3D pwm_gpio_set,
> >         |                                   ^~~~~~~~~~~~
> >     drivers/pwm/core.c:2514:35: note: (near initialization for =E2=80=
=98(anonymous).direction_input=E2=80=99)
> >
> > Fixes: 1c84bb7fc0ad5841 ("pwm: Provide a gpio device for waveform drive=
rs")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Probably to be folded into the original commit, when pwm/for-next is
> > rebased to v6.17-rc1.
>
> That's what I did, before seeing your patch. Note that the Fixes line
> isn't accurate, because it only gets wrong when it's merged in a tree
> that contains d9d87d90cc0b ("treewide: rename GPIO set callbacks back to
> their original names"). I don't know in which tree you found the two
> commits together (I think Stephen fixed it for next?), but then

I found it while preparing today's renesas-drivers release.

> technically the merge commit would be at fault.

Stephen indeed fixed it in today's linux-next release (which happened
after I encountered the issue), which is also the first linux-next release
that contains both commits.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

