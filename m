Return-Path: <linux-pwm+bounces-7443-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EABBCE7F3
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 22:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 11A404E17C6
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9148523D7C4;
	Fri, 10 Oct 2025 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm8s3l5Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141CF21FF38
	for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760128615; cv=none; b=tzC+pBwCWqn9icxGESlWPrmIkxmfQdzuTkrIpv3JNoBujBZ88soUwYV4rcbwdPvo4DQINnz4KyKco5M7kckPJ7SjWahMkoL1KetROS426hWM5hCDcRUCm12yD6amBGCYLUD9GEcdzz/XI3ZJZULTUt6ngV5Lb5zJ4ClVmNecZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760128615; c=relaxed/simple;
	bh=Emo7hhyobRfducLrcbdgGE5EzoH+3R3fQ3ddbvBlCu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6yw/P8vwQaZhhiJaoAtuQK0HGgDXZzj9zcWYRpV38pEjBIE4MZ5kcOxY4+FhkaajOmmkEJ7/+84K0kdDSDVeQyV01ydSFy9F2HRhXso2flbVZ+XakAV8iyawio9MBY+2rLYtg0+SKmPwufswpMH0paHB1mrV13IS9H9LUBU0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm8s3l5Y; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b631b435d59so1612018a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760128613; x=1760733413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z342sgXhiD/O8A715zP2egB65IpjdIWZS6PWIEJhgKI=;
        b=Rm8s3l5Y9ymJS5f9tPpiIQZB0fH47+5z/y/3qFVEU2HwpqmuiN5+JWVBGER64fol/k
         UQu5gTrmnIDOGQH8qL9Y+AYym6bkIepg2XiADGeHjEvUO4qdOxrB256Bhvty6HP7XqSL
         PdFN+Np6FbHnOIaAJa7pYb/9ouErxom+1yKRmoA0bjpQicC7l6t71j+sSeD36NW14d8L
         vHWO0Y6tZb+mVZzSt+4UD05EaROcaMXKdKXPw2jGAn5Rl8OvcJ+xbkUC9RwXZOdfUAeH
         BT3LFyYADKwGLw46TpCRK/w+ABf3v5C5cGTcrcLvcLAGUwx5zRD7ZbpSaQP/q/a1GeUg
         R8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760128613; x=1760733413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z342sgXhiD/O8A715zP2egB65IpjdIWZS6PWIEJhgKI=;
        b=UxYFfuHOhtw7PxRTYczObOUwF1lL+sqdDVyUVipExopHIyEN6q0KfwcxwrOKxKwejo
         As8p4+Vdbbu4syPsHz2ZLn8vHqDBViQaqSQOVN2eZV52C24pButsp4+SxMO3lVaj8Kb/
         JfIog+EvPyR0QCfFK1N1t+T5MD37XosBReuobMA6dWBlI/54wf2vAal4pyN/qhrGcUWY
         nJqV2HybhfwOqmeKHhqB7cJJM223fGtvjkqZtP+2sL5z11oIISyr1yejgSaanBcEwP6j
         yqQ6BfxxWC6FPOWs7VojqKnRMa/yamp378Ms1YNiE4Ke8q9M6bAOCTBn5yCT1Rd5iLNH
         xl8w==
X-Forwarded-Encrypted: i=1; AJvYcCW7VCh3MkZJhdfMJdiBasmAIPLZizLuTPNE8zAwCABwazbPvCT0uQicUUMRhcG1e8PJR1s8lRzmAZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykD0e5KeFZAKeqfZXT9a2b4kgUr/u7wNCxDIwQm6hMEy42ELud
	x71TpVflQpT+ntGQ3mF4PzzrszhHlAbG0ZXUtE/K40OQLaLVP5z2En9B
X-Gm-Gg: ASbGncsLMQ/ZDt9A6c1/vu8H69xECAgS9hWErSTAOJf0h1idYEnc9oLS2WfHb9dM6Lc
	7lizedJcsmKe+Rx+zYhDro1vKI5rOs55JLp66yeywRw3aXT5yoYj+kj8MLjsZ5zD6oepa3I+XSe
	OAu+AxjDlabHakKBSfsBIYH3/nmkD2pDzbQSK+QymKyqKt5KW0U4mQUCcc7sh5oAzZH2a4j2HGD
	HDecPXp0Qw6kO7eiOcg9kKn7/NvcNKRNv5L6oh3+ltxzD4jNICDONirqXlwqF1R44Bgj6OEqp5q
	PlPtQOyGXXG+5xWnuWc/6p0G/nuOz6UB4OXq2YLfti+fNQD+wJjDcKhj1GNHmVqGZHTvSg/j6Zu
	GJaqEQQ7foI6ywQWu0OB3xrrvSNlqVm95qnszY7bT6QFMFeLIDg==
X-Google-Smtp-Source: AGHT+IH9jJP+gVV3DYzKpzglB7kWoF3neWRRoVNVj3O59IVhAsyeWrtkFm3S3KlF9BP78LUiXGfghg==
X-Received: by 2002:a17:902:e952:b0:262:4878:9dff with SMTP id d9443c01a7336-290273567a8mr166430805ad.12.1760128613169;
        Fri, 10 Oct 2025 13:36:53 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034f99fbfsm65398065ad.128.2025.10.10.13.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 13:36:52 -0700 (PDT)
Date: Fri, 10 Oct 2025 17:37:52 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, kernel test robot <lkp@intel.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>, dlechner@baylibre.com
Subject: Re: [PATCH] pwm: Declare waveform stubs for when PWM is not reachable
Message-ID: <aOluoP01oaDzaseV@debian-BULLSEYE-live-builder-AMD64>
References: <1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
 <6v4hny7hxjsdf6zvinhpagtbhluxbd6psq7wpx5ls6zdbnjtym@lnygnkav4ewk>
 <2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com>
 <aOlYDyLzVGbCh5mE@debian-BULLSEYE-live-builder-AMD64>
 <04eb5b1ccc0268ff7e9b88835203771886c5ee25.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04eb5b1ccc0268ff7e9b88835203771886c5ee25.camel@gmail.com>

...
> > > 
> > > I did not tested but I also wonder if 'imply SPI_OFFLOAD_TRIGGER_PWM' is not
> > > similar to the above.
> > 
> > It works, and I'll update the IIO patch to have
> > 	select SPI_OFFLOAD
> > 	imply PWM
> > 	imply SPI_OFFLOAD_TRIGGER_PWM
> > in Kconfig. The PWM imply is because I think SPI offload support meets the 
> > "highly desirable feature" criterion mentioned by kbuild doc [1].
> 
> With imply we then need to take care either using stubs (which seems not to be an
> option) or with preprocessor conditions in your driver. As discussed in the other
> thread I would just select SPI_OFFLOAD. Basically I would:
> 
> 	select SPI_OFFLOAD
> 	select SPI_OFFLOAD_TRIGGER_PWM
> 	depends on PWM

Yeah, depending on PWM is what I was trying to avoid because the ADC can be used
without PWM. Doing the above is the easiest solution - depend on everything,
select everything. Though, I guess I'm technically not keeping backwards
compatibility if I add a new dependency to the driver.

IIO_BUFFER_DMA and IIO_BUFFER_DMAENGINE are part of IIO subsystem so okay to
select them? Otherwise, yeah, they should be optional too (would either imply
them or select if SPI_OFFLOAD).

I'm currently leaning towards
 	imply PWM
 	imply SPI_OFFLOAD_TRIGGER_PWM //(SPI_OFFLOAD_TRIGGER_PWM depends on SPI_OFFLOAD)
but not really sure.

It's sort of a feature bundle we want to enable to provide SPI offloading.

if SPI_OFFLOAD && PWM
	select SPI_OFFLOAD_TRIGGER_PWM
	select IIO_BUFFER_DMA
	select IIO_BUFFER_DMAENGINE

we can have
	imply IIO_BUFFER_DMA
	imply IIO_BUFFER_DMAENGINE
 	imply PWM
 	imply SPI_OFFLOAD_TRIGGER_PWM

but we could then have IIO_BUFFER_DMA=y and PWM=n and still be unable to SPI offload?

Maybe
	imply IIO_BUFFER_DMA if (SPI_OFFLOAD && PWM)
	imply IIO_BUFFER_DMAENGINE if (SPI_OFFLOAD && PWM)
 	imply PWM
 	imply SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
?

Forgot to add David to CC list on previous reply so doing it now.

> 
> - Nuno Sá
> 	
> > 
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kconfig-language.rst?h=v6.17#n197
> > 
> > One alternative to this patch is to have `#if IS_REACHABLE(CONFIG_PWM)` in the
> > ADC driver as David suggested in the other thread. I'll probably do that and
> > drop the changes to PWM.
> > 
> > I first thought of using `#ifdef CONFIG_PWM`, but couldn't convince myself about
> > that from the relatively small number of ifdef use-cases in IIO.
> > 
> > Thanks,
> > Marcelo
> > 
> > > 
> > > - Nuno Sá
> > > 
> > > > Best regards
> > > > Uwe

