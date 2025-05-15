Return-Path: <linux-pwm+bounces-5990-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C3AB7D73
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 07:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0351793FF
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 05:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297FA29551F;
	Thu, 15 May 2025 05:58:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529D10E5;
	Thu, 15 May 2025 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288736; cv=none; b=SYgN8YMwux5217Ipr25hfAHGVWSvfVhvC3xFLcmdol+Gi3gcDHfO4MzQ4tYnd6daiGWE/YqwOkAbpUcQdX2o5dmqfmMOiy9qugzaWt3qb7JXoY/gQ7OQUY/XGrzN3Obpv7H2bEtHKusgfu813sjAJ9SjqGbQH7VzHse2/P9ETuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288736; c=relaxed/simple;
	bh=V3eA9XmMTbZSsgEE/1E8iRYnMQ2agVh2/AN9D1gUdno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtFnE6alrQADVcLH8cSNq6/JaBs0FRl+i0XctOzm+7Z2rtGvNaw/K8wa2Bgp0mm4KnVEI3qQViaNn6N9vDDXtyLcKwHTCIXoOnidm4j+hX8dR0Y66+lQNT0PkjLfGq4rOjHEWMqD2zguYAuXynMDVp/jftKx/Rxix5PuCBI56dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4def04c0ac1so1160533137.1;
        Wed, 14 May 2025 22:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747288732; x=1747893532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynqfndKFpHSGZheFlong6+Dub97owEZbrmGU/IXCCmg=;
        b=jyB4Z5GsqJdUaH4S/csLJxsS/n0dP9sARQ4bXBWG8ltjRBtU2FoxQYsV+zlYwCC9ef
         TZzLa2eyN3XvOIItdSrFY1dHL5M7t0Sfe65iKNK3z48V7frVR1x2m8XAf9bx9S5lu8ea
         SJwmYuNSaYZ1lzj8PoI0jn32ij0ql4aW7brdWMkawRdQ8xlUXzHAN6VVytPCLenhbZZ5
         wBkv6ylS3T13FuuSLxvKZQL5CQw4ylbBKZbih8F5PNpZDJQFDrLt97TrmIdqH4FF3G6m
         GTSUpijbJBOwlg2hp8JzfTGlvZDife/o3MWl0ouCato7ILBRw3IEDR5u7tGxO10CgDe7
         ULDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt0vXe96iCn9JPZHf9Kciau1/yx4Af3IF1Q/nqioHgw6UoQzkL55nIlAihorGeUE/BOiRjMpYzUVhEzGiavB/g/VA=@vger.kernel.org, AJvYcCWsCBmS5QRPapWzvwfuGrD3eo9rrvU/HEb2CFLJ5WkjfOP2g604nfoDX8Wj8u5c5skwsxYCg3pLWCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHH4PxRH3HGgmAAhwu1+QjntaKa87EpKMEurNslYd1bbtzepNu
	fCMaTeHFW/hmDKZcPEy+SJC3TGY4wbR857/BGYyEYy1OGgoGgNLD0MIEmQHlHfWt
X-Gm-Gg: ASbGnctR8z01LyZssqXwNe2YQqZ9IDkYu/BYnAq2clbGZTUtG8+EO09LIGcwJdk5HR+
	FARMVMFk5k5YJkNL6RuwlkToXCF+aShsyyM6ARp2PXuN2AcNIcHBxczj4dpH7tf+ymaolvhrHzE
	HVVyBOUvV71R7DaP1uA7m8Wmx3HKPh1Zm+APcG4HihBl1uxWe2VqsHqs/5wNDToRjKrASmnLowo
	vpRspWzrCMETqSZ8UfsPV3Slf2/td2UmEL8u+JX7zHDgMWhyLYYwgskYtEmq/+Xbf16AR9NV351
	lW7kHlyCey+drVI8nJvOB+p27dwhCCTP6I0r2HcWgaCDsVKoXkzKT9bVrScQCl565h8VqJ8tZkf
	djqnd7AUk8UhT/PjoQw==
X-Google-Smtp-Source: AGHT+IEucrHdyp4mGfnkqcIfHektHkrwev8sOJk7dCE5Y0wi+gEgsXRvfQ4VATmo2CIKEu3ultt0YA==
X-Received: by 2002:a67:e916:0:b0:4df:9aed:3114 with SMTP id ada2fe7eead31-4df9aed3425mr137453137.8.1747288732446;
        Wed, 14 May 2025 22:58:52 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4deb203f7c5sm9574683137.30.2025.05.14.22.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 22:58:52 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52c82c67992so443845e0c.0;
        Wed, 14 May 2025 22:58:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh3I/UOAYgn7+0D8DEGiL7kzRc03mzs8NoRkA590MFpORErctolrwpNj63AOj5DNb+BJCkKS17AC8=@vger.kernel.org, AJvYcCV7+152mbFCH5M6PYEzzkRUFalZKtEq5G5dnBZWG6u207MdJ1CNkk5sQSI4A1x7mOU1365eNo2mHDKOa6NUISUm+MQ=@vger.kernel.org
X-Received: by 2002:ac5:ce87:0:b0:527:b804:ff78 with SMTP id
 71dfb90a1353d-52da902fc0emr1752780e0c.1.1747288731856; Wed, 14 May 2025
 22:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
 <62gkja5ysv47yos2hcurluudxwvl54uv4ih7pjnmnjrzuik6cs@a5oxhyyy6vsm>
 <CAMuHMdUvR8rp2PaFLsyQ6ZWLqw7OskP-ZwVjRC=AARhK8g-iYQ@mail.gmail.com>
 <wytdfpewvcesc6racyrpa4cya7wku6dc65edz7oma7penqrqqq@2g54gyprttxt> <87y0uyu7i1.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y0uyu7i1.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 May 2025 07:58:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSN70bhVOkmL9ms0S2N+N+scyPzxCPxoxttXKsUGa8Zw@mail.gmail.com>
X-Gm-Features: AX0GCFtt5HCXCf1i_3AMLVZ3ScdMqxV1e5Ong-QCWYi3LoLUiE_Cix4INYizIA0
Message-ID: <CAMuHMdWSN70bhVOkmL9ms0S2N+N+scyPzxCPxoxttXKsUGa8Zw@mail.gmail.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>, 
	Will Deacon <will@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Thu, 15 May 2025 at 00:56, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > > However, renaming config symbols always comes with its own set of
> > > pains: users must notice and adapt when updating their own configs,
> > > and I do have to manage the non-upstream renesas_defconfig, too.
> > > What about dropping the rename part? The symbols that currently lack
> > > a RENESAS-prefix do have fairly unique family prefixes.
> (snip)
> > I agreed with Geert off-list that merging
> > renesas-arm-defconfig-for-v6.16-tag2 into the pwm tree and apply the
> > patch is fine for him.
>
> It seems the patch was applied (?)
>
> If so, I have a plan to post patch for renesas_defconfig to update
> symbols. I'm thinking I will post it after next merge window,
> but please let me know if I can post it immediately.

You can send it now, but I cannot apply it before the Kconfig
changes are upstream.  I do have to update renesas_defconfig in next
renesas-drivers release anyway, as usual (cfr. the top 3 commits in
renesas-drivers), so I can take it there.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

