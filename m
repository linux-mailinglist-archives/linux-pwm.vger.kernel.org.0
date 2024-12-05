Return-Path: <linux-pwm+bounces-4249-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5828B9E5048
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 09:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F521882546
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 08:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8571D0E26;
	Thu,  5 Dec 2024 08:52:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7311D515B;
	Thu,  5 Dec 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388765; cv=none; b=SXX3WB3JQT5hw68/VLO37XiOaQOZR4AUV6D8Limj0h7ITBf2kHtKZrYj3RK4HYIaSW6L5ZBmp3Jn1XiyVdV9Sh7m2xZuJ82eTPq/TvDq50uJP7t8Z15fihRQspfvhSeCOpTKe1Ur7LKAGKl70uNXl0u2qpoM15CGc2q/oqQJ0Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388765; c=relaxed/simple;
	bh=CEyqIxfWennY6lI2Y6x8eF2XBHJfHsKT93LeqYmQ6UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5lrWQruN25v2WkgT2wkSuH5dVE6gWUBTyMRARNCErK7d50GHzZA4QEgQ7FMtUkmNzB6cX91hpJcW+wVruCr3pZC2VPfrUEB/P3po8q9kSNU/TYMgPh7Ld8MnRaLFVCjO5tRZsc1efHBNBA/312+9UR0ZO72l61OngcNG5PwaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-515f18355d0so69953e0c.0;
        Thu, 05 Dec 2024 00:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733388761; x=1733993561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDgkIepMe83FtSzdjDrOCza2DlFJA0uuwf52BgOkj8U=;
        b=CSrNxKL3o5S039pjcCQxVpUUHem/LIOc1cKiO9c/FYedfw4huDsbRb1ferS9DoQwtL
         GnrUZK3WaJlm7CFWfkzLCpgYreNohXwIvqbplW3kEV3WBIIKh8G2q7kZYKv8zzhO5+Kb
         PHpLdv/Br6RHW6WrtfWB1SHaVinRevu0TdGx/p/CVgFO2ymz961x1vOmonOr6kESkgNo
         5zJg7LoOjrttl4a3XkBnftpAySwQuH6hrT53HZqZgoDq1+GxPE0GXxsNHzdm0YEUQJ4v
         h7OWIw+P1qCxtIO0KVfJFq5J7LKV2J+YxJqf8ncmdhfOxllztb35rPAlRJ0D9sKOOrzK
         WH1g==
X-Forwarded-Encrypted: i=1; AJvYcCV9PF2oIvCjEg8Uoyg3qOhd/0VJw0Spkwkl320XMMa6Wdumyk450JR/wyRL8QTN0ZQFbQMS5Uaty5A=@vger.kernel.org, AJvYcCX6SN+huXxcxucU3ge2w47XCvUOrrDagUEmvQfM1zL2IQZXIFEb+yALoVfWl6V6oYAcnyVS+vpLqSThUW7xOU6WCq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuItvcvDP2ywE4TEknkSDIBE7xBj9AeLGTFhSpMSUERvMiYyCY
	UJ02qyZYeSR8Lma01UfwY3QhTaV++0BZ7l+3F0z0+Yio6kHc3Q/S0tfFcNgA
X-Gm-Gg: ASbGnct/UC9KgLK9IMKfxYAqbXzJR2MRaOurMRJoGKx+JKDCir3IKLUz34mg0CuwjdN
	IhnZo9zvUXyR3HF8NEStaCcklEfP4HCVStCrAJOVtnnR4wQzW1IXAPE5shVEEh7fuHuRwQ0Ckpo
	3mV5UFfXvVlcM+OqM2VbHTnstWzFVVHxtlhs3hkRbw4vf+rqljOkbvuVOjxNOO3efJVKqWhWfjZ
	NhE9XiA6Et2e6/O6z1wDjd0gJI3/awtZk70UEgtfJu3r+3z1R63pWE5QA45ajKt8TnmInD+5uXx
	OvzEc1jB+b5Mh/P6
X-Google-Smtp-Source: AGHT+IEJjbjWf8TpLh9jUoXZzlmuBTjE25AYz/gsCpivXzQksgBJVnd9brGTJb6K/Xln2BzrOuwzOQ==
X-Received: by 2002:a05:6122:30a5:b0:514:f579:3bad with SMTP id 71dfb90a1353d-515bf63cfbdmr13138882e0c.9.1733388760986;
        Thu, 05 Dec 2024 00:52:40 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-515eaf32861sm87324e0c.42.2024.12.05.00.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 00:52:40 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-515285c340fso203489e0c.2;
        Thu, 05 Dec 2024 00:52:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVxPYJtLYvsi8DNNLCMfauYXN+h7dYUV+wfGbYfECSE7BjSVrHouG92ZNxBE2QRpk5RbwuxZDsxrQ=@vger.kernel.org, AJvYcCWAOUC0gm7bvkY3N4s9Rs6Mh0Vxkafpr46uOw6uQE8eIlN9FS+Gg2wdGSZYAGvPWuOGR3dG6i2oC3HuYsLXDzMCl+c=@vger.kernel.org
X-Received: by 2002:a05:6102:a49:b0:4af:be9d:7ef with SMTP id
 ada2fe7eead31-4afbe9d0890mr1487099137.13.1733388760349; Thu, 05 Dec 2024
 00:52:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-4-biju.das.jz@bp.renesas.com> <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
 <TY3PR01MB11346421B5C0C4A193F70C3A586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <phr4mtucfmyuhaywspzpxwqvwmklwcgsljcc5dvzbft44kengw@65axncbiotf7>
In-Reply-To: <phr4mtucfmyuhaywspzpxwqvwmklwcgsljcc5dvzbft44kengw@65axncbiotf7>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Dec 2024 09:52:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBb2-GGhyhubibbuSea9xVZBear3FXb11EO6gYn8r2Dw@mail.gmail.com>
Message-ID: <CAMuHMdWBb2-GGhyhubibbuSea9xVZBear3FXb11EO6gYn8r2Dw@mail.gmail.com>
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Thu, Dec 5, 2024 at 9:28=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@kern=
el.org> wrote:
> Well, the policy is to pick the highest possible period not bigger than
> the requested period. So if B is asked to be set to 5ms and 5ns is the
> highest currently possible value, that's it.

Really? So overclocking is preferred over underclocking?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

