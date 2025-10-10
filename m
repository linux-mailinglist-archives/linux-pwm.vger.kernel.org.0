Return-Path: <linux-pwm+bounces-7440-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF9FBCE530
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 21:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E0724F4207
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA41F2382;
	Fri, 10 Oct 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efBO7K7c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120F19C540
	for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122838; cv=none; b=I6CpDYV1w65rGB8CiX52zK6tGwaFMqxJDtTRm55BorJo5maYrZR8hghC2VQIpX0+1fweeGM27otnIACrTYZ8/7L8kXHBDlI48xeygwEOda9HCAFV7aCy8CcbuEgFymNZ+4R3pQsyw+/Xih1tJTbo1CjlcUpNxok1aO0VP1WjpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122838; c=relaxed/simple;
	bh=9QbibVrU4oGfD1eZV4UUiLIn3J15GgS7qu5zKwYymlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLv69d5XlOez09hAaOd9EeFfpc+x+CXwA3jV+cat5ED5iXpHCpA8H7RH6DY6zP9/etivrF4Hle1gR0lp6esJrPS4Xk3ipCxQ8snGM4IGtTXjGTdu+CNPWEE7YzLcxqw6HC14AgzAO8XgxQYC7nYoIPdRa2Kpc6f/u3y1DWBxiaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efBO7K7c; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33274fcf5c1so2710749a91.1
        for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760122836; x=1760727636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ia3IBt5aepwAEsrhKPZ/cravnl9YsfuXuHMV1zSDRL8=;
        b=efBO7K7cj1DxBFnKxl2EbTsQr9kE800L6Y7iMamsve9TJVIIodqehlybY44csydTcI
         BpJZep94vJXpGZRGR9figqkUU95i+3IvZwXg8uCN4Z7Abt9rzC3a1ggATPt4l/f0mVoZ
         QZCNyphGc87dBz7IlHpaWK6/b2dI4tSrn/P+ICIviSre4RyhEVES6NXCPXjkpBI3f5G6
         3fxH6UIu9yqD0F/Wjcn6of7oiGvLjM9gah+5fzYYNRlR8fpITBanAnWvSC/81hug5WUe
         n1GNvnpeClQ62gYOUA5FYQyeUkuNaArK4QbAQOPhwF57B2jQ0SJjbHEHbpgvPzXKNXJj
         bFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760122836; x=1760727636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ia3IBt5aepwAEsrhKPZ/cravnl9YsfuXuHMV1zSDRL8=;
        b=ZaE66nPhCyIKW1g+CdOmQrGvo6pi0G4Zch+Fb7l1zIpXW/d0dL3Sh1LcM6F6ZdoL0O
         5YsHWHCjK/shw319WWJ8ZvwjP7VRcmDN+0pJJg1e06O+ZGbx+ri3CgaO1az4kMhpG/bH
         S3TnXiY3PZ8yoJVWltnis7Eqbz4kL/couXWEGI6ZTBjaGOEfxYayj1d+Mqsc3LoowOXX
         lJPZvaDsPmgcD5GR0CFSc2DDBtVIuk+QSRw6P+Fw5BkUQvwy9Lg8QNb5wuHJ965RxGv9
         Z1EoPxOzzjgOBVa2Cikb5lmVBFdctHwMXoDA1T6pTxn8DjlemfZLGV52j1crt9NEaO5O
         Sz1g==
X-Forwarded-Encrypted: i=1; AJvYcCXzj45D1WbMBkV7UQCjFAhs44As/TEbuyV7vn0Nz/eAjFUmvPorgse+9jQ4HvXiB0+UUr0VUmz7lFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UzMmt7aZ72fIw59nOP175aTq8gVZbBLvdLUUU6MAzEWksieG
	DMnCtgNi2V+hodQxulgx0ZqF85S9XF9mpelNVer5PkfdnXuU3jREGQnL
X-Gm-Gg: ASbGncs+o9mc5cul+EmjVrJocBSqJ/5VB2nqmuHsiYgM9Zl0bm5RjuudNZcNY6Dnydm
	kRKj3V+rEVlpzyMN8TbPgEK82wfBei4Ynhj6vBIGOrE7kWBFLHT6Q0aTK3SjSeAZUVjaAH9pBVp
	ZiA9uF7fkQ18EReRKT9JrgdHFy1oScHrKI7yz3Wib+o4+s8rqVnkyvQoQx/l5IqEoJf7kJDL7yD
	eo9ybC1wzIvxCyhWQXGr2AISsnCjhLh0wBXBeKpKT7aplov3bCFg3cybEMOxuKvasejd5PuyJUU
	IDChVPRtou0drC/RWcCdNu8Zr11DpTw4jWxI7jj3RwdjY6Ao37AE1PsJ5uPNb3wL5hbxANNW5tU
	T8LwX3oSjOxoG/WIwy+rOSBKjA2t9qPjVw2kCG4UANsroAxrmtg==
X-Google-Smtp-Source: AGHT+IFLRQO6u8h4erKgCYW5k6dKiFNb18iD0j/hp4v670oN8xLMwr2HpIO4ZG38GaDseIzV3sAYPA==
X-Received: by 2002:a17:90b:4b04:b0:32e:8c14:5d09 with SMTP id 98e67ed59e1d1-33b51105bbfmr18545944a91.7.1760122836057;
        Fri, 10 Oct 2025 12:00:36 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33b61b11ca9sm4015345a91.24.2025.10.10.12.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:00:35 -0700 (PDT)
Date: Fri, 10 Oct 2025 16:01:35 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, kernel test robot <lkp@intel.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not reachable
Message-ID: <aOlYDyLzVGbCh5mE@debian-BULLSEYE-live-builder-AMD64>
References: <1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
 <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
 <2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com>

On 10/10, Nuno Sá wrote:
> On Thu, 2025-10-09 at 18:53 +0200, Uwe Kleine-König wrote:
...
> > > 
> > > Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for
> > > waveforms")
> > 
> > At the time 6c5126c6406d was applied, there was no user of the API that
> > doesn't depend on CONFIG_PWM, so I object adding this Fixes line.

Fair. Looks like the stubs are not the preferred solution so probably going to
drop this patch. 

> > 
...
> > 
> > 	WARNING: unmet direct dependencies detected for
> > SPI_OFFLOAD_TRIGGER_PWM
> > 	  Depends on [n]: SPI [=y] && SPI_OFFLOAD [=y] && PWM [=n]
> > 	  Selected by [y]:
> > 	  - AD4030 [=y] && IIO [=y] && SPI [=y] && GPIOLIB [=y]
> > 
> > This is the thing that needs fixing, i.e. don't select a symbol with
> > dependencies that the selecting symbol doesn't assert to be fulfilled.
> > 
> 
> Agreed. Seems to be one of those cases where we select a symbol that depends on
> something.
> 
> However, this driver can indeed work without spi offload and hence PWM and
> SPI_OFFLOAD (AFAIR) are optional so I wonder what's the right approach. Looking
> at the new series I already see:
> 
> select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
> 
> Which makes more sense but I guess we still need the stubs with the above. But 
> I would also expect stubs to be needed for spi/offload/consumer.h. Maybe I'm
> missing something though...

I have successfully tested it with imply SPI_OFFLOAD_TRIGGER_PWM in Kconfig and
MODULE_IMPORT_NS("SPI_OFFLOAD") in the ADC driver.
Both the PWM offload trigger and ADC driver were built as modules.
I'm not sure the import ns is needed, but ended up breaking the remote test
setup so will only be able to tell it next week.

> 
> I did not tested but I also wonder if 'imply SPI_OFFLOAD_TRIGGER_PWM' is not
> similar to the above.

It works, and I'll update the IIO patch to have
	select SPI_OFFLOAD
	imply PWM
	imply SPI_OFFLOAD_TRIGGER_PWM
in Kconfig. The PWM imply is because I think SPI offload support meets the 
"highly desirable feature" criterion mentioned by kbuild doc [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kconfig-language.rst?h=v6.17#n197

One alternative to this patch is to have `#if IS_REACHABLE(CONFIG_PWM)` in the
ADC driver as David suggested in the other thread. I'll probably do that and
drop the changes to PWM.

I first thought of using `#ifdef CONFIG_PWM`, but couldn't convince myself about
that from the relatively small number of ifdef use-cases in IIO.

Thanks,
Marcelo

> 
> - Nuno Sá
> 
> > Best regards
> > Uwe

