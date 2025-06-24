Return-Path: <linux-pwm+bounces-6500-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D9AE5D5A
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 09:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB61F3A955F
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 07:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDBC239567;
	Tue, 24 Jun 2025 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HctFox7l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB220A5D8;
	Tue, 24 Jun 2025 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748688; cv=none; b=oCI1Dz5bdjO8SstMb9Eu6cjbvObOX9HjOrK1wgQswGDEd6Nc19MVK0RYcr1u2IWbjRNECeeT4iRptfRH+i8lXCXcHHLQyLniqkaTEf4Z7ZTSIRqNVOueJi/IZpQXwZP5NVnRat8SYwHs7OVzR34hIuFoAiBbUFV+LDX0GP5P3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748688; c=relaxed/simple;
	bh=3L8zVA2ueuJ98h4O9ApjC8lw44r2R1R4pYIOlzcPuI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHZg4Utz5SL4feoCchUMibAo+H1OzoUQqWJezHqISFeMWph16p/od9h4mN7VQ1F8mslVDAn4/Ynee5hvarXHEnvPYoCTlidSJ0PrGzaY27QLbctSXiiYdpc3d06gQ4oO187VI3fxGzw3J/CV2oFQWymqGkpOuAhQMk0H7gevQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HctFox7l; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so47247f8f.1;
        Tue, 24 Jun 2025 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750748685; x=1751353485; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ldoS5jcwhFZyQ+2I13CKfPxsMRdOZ6a+TpT13V19plU=;
        b=HctFox7lAZajpt3/OKoqmps+BjVWw8vzo3RCTAMlhMhyJvB/lp7uGZQN5q5T6NIWgo
         E8OS/LaVNcMX1zgInwnqoIk9ZqdoQtWrQA5cobBh0l5VDr1TFVLv0BTwE/pKTqJXVh10
         +2rN98MOb5QAVuKsUnX3bxxV7DxUjciprFEgYSEAocSfuAdvUMOm0XYEImGSciNgMQ4b
         YTpXixhoWa941rHp+Kw3N2RJVLZ3VZSHPpZugkDfg9nQOWFedPmLm26TqD0eOO6PAQfI
         5taiDV66o6A40HLXFYDqANpUVypNMh+sXaFltOsOvT0DRmusM4rdbJNGp86Yte/b9Nz2
         qaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750748685; x=1751353485;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldoS5jcwhFZyQ+2I13CKfPxsMRdOZ6a+TpT13V19plU=;
        b=K2PLrfWfzVXQ50uZ+9/zefINNtfuBgDEgBg2vNEfzVlNRK/YQ3x891YmenhugtbpM6
         7qOw/CQqYvirYxbMoHCmweGO5pXw/OdjPgHRZFb+XUKfWsBA7/CfZWPZ0yRHRXuZXDqQ
         YZHQa+DV+ct4aowaedcxRj3BzLjgLuybZMANdEL1Ldno+ChEXUAjhzdHENX/nhKu+2pA
         SQPjAGup8mqqbdCXuxx1aeTcXMtcBAlAQFY/ZCfjj6TvhDFIxxmtKI1cTibOjj5dK5A4
         wA3ci9ZdSI+6n/b7AeVMxxGl7LntNEPp6uyC7WsBhtlAGC48sVnnmN68hJoVWTE57eAI
         5Hqg==
X-Forwarded-Encrypted: i=1; AJvYcCUPoEBo6hhAFcXApUZi2Nhrbi2DMenS3ZYSRQLbHoJTKDfMO9Rs/yxdMCFrN3b9zdO69VEAGUkz3Ye+Mg==@vger.kernel.org, AJvYcCVuYohlBeNIKEpd9Zt080BYtIHqtcufZO3ChN6llBt3RBNgh7egYJfnFz2TId7uwtbz7iYf9EHay1G8cOL+@vger.kernel.org, AJvYcCWg4vKwK9aow3i3NR+RFSc1ZYk5f2oIF0K3vpG0YL5ZpGcxzHQmRiwWpgeiY4P3ER4+PIJgxmzk0h/H@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxi2ZL0RXDL/MNssb3xUijwMF9sWyqIZQIhvPTvsDwSctPtT4e
	Fis7jtUsG5OwAcWibyzFnHed7yFKY34yk6mEydw7tZF5GodXVK3tk71T
X-Gm-Gg: ASbGncuNQoGzDQi+bOWlbWw6tRyMP0TA70ZkOu6gGD83rqE36556G954nRHPpgAVnVh
	3StkN5pSXlxEnjEbxLIbr06s5MFoudqMTuZPCA97VYq48UALnVdyIZxWi+i7F9yBZY89PWmvyUd
	A4j3g+uIhqHOdkBFHSiC+J+wWDk1vHz7e9FOUaB3MXSKCYWudbQ9f8xDPMTUJ36Uv3dPhKTyqvP
	XV9bMY/J6hDhsfEzRF36WODroQdk0buyAM2Q2yMKZ8rFEqBglhGoPFeA5jxqYwaYL1jFUmleQea
	puY/X9StAiyj0rIXJRdi7mzzMkBaDHpOHwf+XQh3l+SNcwTFBbFG3ZxvHO4=
X-Google-Smtp-Source: AGHT+IFLnIIvnfFaira7QlQiLZpMYoYe8pvFntKV59gZwf40Yu7Kvn30zOxxdw3g68qAAQQUPUQLCg==
X-Received: by 2002:a05:6000:4284:b0:3a5:2f23:376f with SMTP id ffacd0b85a97d-3a6d129de4cmr13306333f8f.13.1750748684895;
        Tue, 24 Jun 2025 00:04:44 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:6bf:b400:47ca:3373:65d:a678])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805d21fsm1131162f8f.23.2025.06.24.00.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 00:04:44 -0700 (PDT)
Date: Tue, 24 Jun 2025 09:04:42 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <20250624070442.GA3383@legfed1>
References: <20250619-mc33xs2410-hwmon-v3-1-301731e49f8f@liebherr.com>
 <cviovwci5fgtyina7p7zqjns7cwveivy3vetqhhagwmrlc2gm2@jrqgorif7xff>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cviovwci5fgtyina7p7zqjns7cwveivy3vetqhhagwmrlc2gm2@jrqgorif7xff>

Hi Uwe,

Am Mon, Jun 23, 2025 at 11:07:24AM +0200 schrieb Uwe Kleine-König:
> hello Dimitri,
> 
> On Thu, Jun 19, 2025 at 07:32:42PM +0200, Dimitri Fedrau via B4 Relay wrote:
> > @@ -29,6 +30,8 @@
> >  
> >  #include <linux/spi/spi.h>
> >  
> > +/* ctrl registers */
> > +
> >  #define MC33XS2410_GLB_CTRL			0x00
> >  #define MC33XS2410_GLB_CTRL_MODE		GENMASK(7, 6)
> >  #define MC33XS2410_GLB_CTRL_MODE_NORMAL		FIELD_PREP(MC33XS2410_GLB_CTRL_MODE, 1)
> > @@ -51,6 +54,21 @@
> >  
> >  #define MC33XS2410_WDT				0x14
> >  
> > +#define MC33XS2410_TEMP_WT			0x29
> > +#define MC33XS2410_TEMP_WT_MASK			GENMASK(7, 0)
> > +
> > +/* diag registers */
> > +
> > +/* chan in { 1 ... 4 } */
> > +#define MC33XS2410_OUT_STA(chan)		(0x02 + (chan) - 1)
> > +#define MC33XS2410_OUT_STA_OTW			BIT(8)
> > +
> > +#define MC33XS2410_TS_TEMP_DIE			0x26
> > +#define MC33XS2410_TS_TEMP_MASK			GENMASK(9, 0)
> 
> Keep the registers in address order please
> 
Aren't they ? There are "ctrl" and "diag" registers and I didn't mix up
adresses. There is a comment for each of them when defines start.

> > +/* chan in { 1 ... 4 } */
> > +#define MC33XS2410_TS_TEMP(chan)		(0x2f + (chan) - 1)
> 
> I wonder if it would be cleaner if this was abstracted using mfd. Then
> the hwmon driver could live in drivers/hwmon
> 
I will have a look into auxiliary devices as Guenter proposed in a
following mail.

> Liebe Grüße
> Uwe

Viele Grüße
Dimitri

