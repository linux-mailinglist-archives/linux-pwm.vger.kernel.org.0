Return-Path: <linux-pwm+bounces-6181-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F96AC8B68
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 11:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C831BA13F0
	for <lists+linux-pwm@lfdr.de>; Fri, 30 May 2025 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B2521B199;
	Fri, 30 May 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCRyxzoL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEA61DA5F;
	Fri, 30 May 2025 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748598512; cv=none; b=tVE8VTINKrKan37XYFU5Ay9iD6cJ+bAocRA0OuX/diPERng8vtp+gJ+NHmlp3vd4WOGZGrTgK4dpbnztIwl0nWWQPV/MjgTWmaqhnkHAxib9eNJjSWjMbj0BhbhpaaActcU4z5RQrrIJjk0qYp9ZP2jubDQlea4qfn/6NygS/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748598512; c=relaxed/simple;
	bh=YudCrucAx1p31d0Wm18PRjT20S5RtbDxkt+4OGkxwE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U24RiEfMTdup9TyayD6SJfBiy57obuaerEwbAzmFExiLztbxqqxJD0AMIWljvJn2RfTJUOiHkvR4fR5O4TC65PT16FObPZY3Qb0Psnq0HeuLdrRz4QMyoVo0t4SROjmrNtpt1XIV7oXQnpKfQ1SXyyUOyRbwFtp6vVgZSsXqMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCRyxzoL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234e48b736aso23355695ad.3;
        Fri, 30 May 2025 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748598510; x=1749203310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ookjxClzf4cQCEvAmXl0RF2BomztovFb9LfDcMb8UFA=;
        b=jCRyxzoLtVUvGvPoQeimce1dbXHpdBli7vuqY0ejqNyTlH3XDuElwF4Vvj2SzRr0Xp
         2Rmth6j77BGhHcBCYhhAD6Dm28zAUmB5alXbYjLcMglt8iPwtT7HdmB0cqTH8uFfoFT8
         cICoVd05BH6vhljYxygmAUt4Svn+F/DuYg9qEfUYUZdfsGilLlIcGMYMeS7uJGg2Go5u
         4LPpPJZ4wg30LmQ/cAK6w7Ldd7w4YiRpIZzvU/gqpC1xaIP63m3tpC7UjhIenrl566TM
         WAU5RvG7Zszu2xZzifzQlzI2O3ESskzr+C8l1A4R9icxysfPHIqYHZ4OuT20LgC+SYs7
         i0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748598510; x=1749203310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ookjxClzf4cQCEvAmXl0RF2BomztovFb9LfDcMb8UFA=;
        b=anwym11AaEKPQ+RX4f73VihMX3wMBNSSheaHymdw0jqAevS7MOwl0IBP6wP6ajSD4W
         QiunSpdwZYbigUzNSteR9vnuz4tIg0DBWK2v6gDzn+sc+7oeOOjnBAKgrFZcIeKz+XK6
         JJhu/4D+nbL+c+o7c7h/CikghcAITwk22AOG4EdXBoougNRfmbW5B1Ayf+sYboHJxszy
         AtpSa46UF6dU0mJBQPT8czYQO/D09eiHqgqx0Hb8IQQSBT/blTvRdyEj9j8++kGq6XDq
         3/XUcX6cPOdNV4PQX+lWfA6S18khnELPCHyPDSDnJTx/ULL3GhPvFg8cn6e69Bex3mn7
         JX9g==
X-Forwarded-Encrypted: i=1; AJvYcCU5iUfig8l5zgW0NxspgqBTIpQbr/30OAr/5+jVmU7lz6iov30UmE6J8N/2UdzYSivmOzVdYLWg0UZD@vger.kernel.org, AJvYcCW9MXmx9gVbkh3zHKb+dqfHOsSJiKEVOrvBowPHxQUMWfSSLAZ0xk64wy2LCYdfVC/l1nbJvaLrfYAFsVpj@vger.kernel.org, AJvYcCXimutrj3Oe0OJvjezn9tbdBWl7Pykj+df0LUK6Q3i8srZeOfB4QGQsLiiDNyjiR+ALqG2NCn9a3XUL@vger.kernel.org
X-Gm-Message-State: AOJu0YztMNz3/S0JJp12jZ0PR9W9twSpRXJT/g2cicYQMx51lMCLDLBx
	1r2c1gIpQK4GIwF0wjeakE75/YT+dFi5cZRsxukyAeVvzzmFmgiCXQ6W
X-Gm-Gg: ASbGncvzk5vy4DActPhuP/4ag2jCNr62qkFkh1Ocfiq0bzHebmkqolF91wsvhG29xHb
	tAMKU37YbXXERm4/5Jrhj8d7lwEIPwwfYRrRbmaATCZ+WvRa/lmihnkzCdG84y4UgWe5Q2lR+Y5
	bWEgN0UI/iYQlalzE88k3Ba2KVQbVZ3aIB9P4VespjNLD6OBMK09qQE0Lup0brA5dToFTcMSc88
	Ct0K1zGsVB4C1TZj4JPjaxyD7ckd6tm6gUj+7HqR40CGWnyIVmSciGMWXn6dQO2oJ+5zNNCf3M+
	wNy+cDk41SFEfKmIevfHlcywvoQH006YZfegtaw4kmNRLMtoFM5R
X-Google-Smtp-Source: AGHT+IF9sCFOftJujauKnIRomaigvG8t61Ftfb7NDiYEGkXgDAJ4CTIfsKr0q6wuZJOiHiCtJPc22g==
X-Received: by 2002:a17:902:c952:b0:235:779:edfe with SMTP id d9443c01a7336-23529a11512mr38942725ad.43.1748598510306;
        Fri, 30 May 2025 02:48:30 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506bc8483sm24863795ad.1.2025.05.30.02.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 02:48:29 -0700 (PDT)
Date: Fri, 30 May 2025 17:48:27 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 3/3] pwm: sophgo: add driver for SG2044
Message-ID: <oo3pevzuyhrsf7t2ja7mxytaxhnthfar73iwvqxgawr5gjiudf@hbevzjog7akj>
References: <20250528101139.28702-1-looong.bin@gmail.com>
 <20250528101139.28702-4-looong.bin@gmail.com>
 <azf5lzfkegr6wt3mratxra2mlfah45dc3comtkjbrbdzf4x5xc@tlzxp7oqtcfl>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <azf5lzfkegr6wt3mratxra2mlfah45dc3comtkjbrbdzf4x5xc@tlzxp7oqtcfl>

On Fri, May 30, 2025 at 09:50:25AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, May 28, 2025 at 06:11:38PM +0800, Longbin Li wrote:
> > Add PWM controller for SG2044 on base of SG2042.
> > 
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > Tested-by: Chen Wang <unicorn_wang@outlook.com>
> 
> Nitpick: Make your S-o-b line the last line. This way you document that
> it was you who added the tags for Chen Wang.
>

Thank for remind.
 
> > [...]
> > +static int pwm_sg2044_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> > +
> > +	pwm_sg2044_set_polarity(ddata, pwm, state);
> > +
> > +	pwm_sg2042_set_dutycycle(chip, pwm, state);
> > +
> > +	/*
> > +	 * re-enable PWMSTART to refresh the register period
> > +	 */
> > +	 pwm_sg2044_set_outputen(ddata, pwm, false);
> 
> I'm astonished that checkpatch doesn't spot the wrong indention here.
> 

I re-ran the checkpatch but no error. Maybe there is something wrong
in checkpatch.

> > +
> > +	if (!state->enabled)
> > +		return 0;
> > +
> > +	pwm_sg2044_set_outputdir(ddata, pwm, true);
> > +	pwm_sg2044_set_outputen(ddata, pwm, true);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct sg2042_chip_data sg2042_chip_data = {
> >  	.ops = {
> >  		.apply = pwm_sg2042_apply,
> > @@ -142,11 +215,22 @@ static const struct sg2042_chip_data sg2042_chip_data = {
> >  	}
> >  };
> > 
> > +static const struct sg2042_chip_data sg2044_chip_data = {
> > +	.ops = {
> > +		.apply = pwm_sg2044_apply,
> > +		.get_state = pwm_sg2042_get_state,
> > +	}
> 
> Missing , after }.
> 
> If you're ok, I'll pick up this version and fixup the two code changes
> and the order of the tags in the commit log.
> 
> Best regards
> Uwe

Thanks, it's ok to go.

Best regards,
Longbin

