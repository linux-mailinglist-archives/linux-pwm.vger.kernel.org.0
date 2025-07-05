Return-Path: <linux-pwm+bounces-6737-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EEAAF9F41
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 10:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240E94A6CAB
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Jul 2025 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C123AE62;
	Sat,  5 Jul 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWvS+x14"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F431B87EB;
	Sat,  5 Jul 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751705662; cv=none; b=UQ6Fs9zvxXDKJiXXG68iiO3qI0PxpOeiP9qo/oqSMNgy0a+YJXcKgVgJWfOXoWDKnJsNZKxrLyb2em2KLXxTrxBlnxFJonOzk3qI3sQmMt0A7i8o/A+E22q4jPmxwLNy5kCFzHqNeBIR9v3rgZkMA6Ns8ViL9N23oaX3xdmszi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751705662; c=relaxed/simple;
	bh=CUPpDZUa3QuU+NGttTzTaNHOrRBmC+2nM/nqavBLNdE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O01z0vCmaTUNEkrv8u8ORXBCLdxr60CRhn0xN1ILmM7K6YS8C5Gg5I8VDzgFNjaD0q8M4ybZ7zP+0P4QPh30uNrhO326L3JqrIMefNqaIlR7Or3HVIFHyBiR5SdS/Wdse3G3SkCI7EEORDERnDgpftStL+CZkos9FShsgKV9PRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWvS+x14; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so10201265e9.1;
        Sat, 05 Jul 2025 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751705659; x=1752310459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vvIRbUB61GVB8bR0tMGG9gJqcSl0CknkzZsodQ81bs4=;
        b=GWvS+x14jYPuk+RUe2US1xdMjiPT6JbQwQaD4J0K81gzuRAXuRFuCXiyM+3xSBf63D
         uZi4u5aVwLTmmuk+ZAqs4ypgjKzMdWYkSz7N873Qk6N+NgU0yqJ4F4mFCBFr4L8GsyPK
         oam1hF5gAimNRZYoNNsBSvmZlc0Pqrls0J52BMHSBh7VdMhx22jCo9h2+TgTZZoGqytE
         vm35wPZK8TTQTDnNQxTXLJcjYLDUZhmqZleAMzY/8fgLn/QSZQ83H92UplJ309IRluML
         SaNItG6T0VMGixSxMRmumn/c6vUg1V1VyfZqxrYM3yuTzJH02NiHtgBxrxqJZ5LjPJop
         2Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751705659; x=1752310459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvIRbUB61GVB8bR0tMGG9gJqcSl0CknkzZsodQ81bs4=;
        b=mwbIfJv6+oo25asjsIx9u6Y6vWgDVcAL0i+Y2H8WSjWUznQ6PswAUZ+CmlxR9SwGCX
         uJOzY/kamoI4uRECxE/QkEiHjcl1KHbDYwvLhZ1uZQAu2NNZtlvdWqPMskruy4f01aDR
         MSaMr84/495UresHJfij3ySihzubQHopR8fftsnWsQFqUsznfGzP0AZL5vX3RtOrWprF
         JWH3+hBa1Dv+d4s2zgj+vx2H2Z0KyvVp293HvvlODt+JkAulAw15grV7FCVgeNK4ky16
         rlqcYFgE12NLYkmv57vICLywPgyDjR3iEddlR0Wjn/sTNX4FH/6YBubP7D5yL+dGSNOW
         gl9g==
X-Forwarded-Encrypted: i=1; AJvYcCUaTB4e+mbSHt+uWuugkzdTMxXzwyvj/PLqYELXLs7PDFwU6/K7ksSs9UbeWf5A6j4NmpR7JhjTNoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5GIv6wJlu9eiujNGfbL4GeZ2HyPtAyXPgJSIEkHtPbu330jXy
	+ihULDlNpC2L3ws0Dfr0T2C8gyFaof6pc9iL5T7N8SSVGH6PqPxoUoKR5nG8tw==
X-Gm-Gg: ASbGncua04dEMoIbjwnFcBwvisVpIzS7Z7ueTPl6NXfH6RBYIRrknODRp5fL0ZhJHex
	q9cz7Oom18XAI5wcqyr423eCWeP+9ZQgER1CcSY1kiGt0KPId1OclJl3ILFAJ0YjiKp8U8exKun
	VGTCd8wrQ3c0TGXA9sewhX0VkMiKYhXcFgMIqKHZRpmyLHvRKX+w0RW6zaesKWt2O/ESKCDVXqA
	A7q8JNc4wCheBDgVoOWKveBdps6gbYbGTaU81R4SKON0uFezcrRN9okO3TBd7oc04MRHu8kcs2/
	fXa5P43taMhewMW5ZxyT5kF92JeLcwOHTmzfEaKVG1IXd0uUaTCgZYO1jZfwsdFM/bPAzHfYLYr
	q4aSU9Fo5X2ep8OFgO3gd5o+JU6sO/El5z6/dB44Peqxu
X-Google-Smtp-Source: AGHT+IGCTlSQAuwnvNNQjJ8nrzv2WSzfYMVMO6N9w8jD4ohSwwPC7KkRRgHbhVeb4v8FjfWeiQmsHQ==
X-Received: by 2002:a05:600c:5028:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-454b1f6de87mr57909105e9.16.1751705658618;
        Sat, 05 Jul 2025 01:54:18 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-46-252-169.retail.telecomitalia.it. [79.46.252.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9969aa1sm79906465e9.6.2025.07.05.01.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 01:54:18 -0700 (PDT)
Message-ID: <6868e83a.050a0220.2d26f8.0920@mx.google.com>
X-Google-Original-Message-ID: <aGjoNqEY-r7CC9aX@Ansuel-XPS.>
Date: Sat, 5 Jul 2025 10:54:14 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v21] pwm: airoha: Add support for EN7581 SoC
References: <20250705072825.26497-1-ansuelsmth@gmail.com>
 <k3s7wp52oljegusctucabvo2wcmx7defklk7fdtqh32a2vvcux@7tuafqra4nrw>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <k3s7wp52oljegusctucabvo2wcmx7defklk7fdtqh32a2vvcux@7tuafqra4nrw>

On Sat, Jul 05, 2025 at 10:47:37AM +0200, Uwe Kleine-König wrote:
> Hello Christian,
> 
> On Sat, Jul 05, 2025 at 09:28:20AM +0200, Christian Marangi wrote:
> > Changes v21:
> > - Revert offset to u64 in airoha_pwm_apply_bucket_config
> >   (do_div require u64)
> 
> I didn't look in detail, but I wonder if you considered using a
> different division function to keep offset not bigger than needed?
> 

Hi Uwe,

I used do_div since it can calculate both division and remainder in one
go.

The kernel warning were present only on 32 bit and are caused because
do_div implementation is different on 32 or 64 bit.

On 64 bit it's simply

rem = n % base
div = n / base

but on 32 bit it's much more complex and adds the check n to be an u64.

Also on 64bit n is expected to be u64 but given the simplicity the type
is not checked.

I checked if there is some kind of do_div32 but it doesn't exist and
also using cast doesn't work give the complexity of the macro define (I
tried with (u64)offset.

What do you think should be the best solution here?

-- 
	Ansuel

