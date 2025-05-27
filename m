Return-Path: <linux-pwm+bounces-6137-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B3AC45F5
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 03:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBB616FB34
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 01:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB413B5B3;
	Tue, 27 May 2025 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8YBtVQm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D66A17D7;
	Tue, 27 May 2025 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748309972; cv=none; b=R9h5XY9RCN23YB5vJhBPh/G5R/gGBDH6V7YTrQMRGT2Bmef7HmcQrNJ0kU6+qA4j14WBBWlkW5YaroVlco1tJJyusO9GDNiRj7SHNhrxRAVve6tWtROceqJ4yeOOwiwtB/hWM82WZAEk5I37REBt+xVCOditLVGHHX+/78q4hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748309972; c=relaxed/simple;
	bh=dHorA1JsrJHj2mnKGRfK+Mfyj4dNsLG9DWmxMquEkxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPG4TzGwltg3Wm1bteP5iU++G5ZIkXPP2EKsaCabN+ZpXb7MOe7NXSi98RpnI5imCbAXpT4vGb9xsnG4pCRVfQXIk8DKv96v87UH6d1yixHslwQ1Z7ywat+ZiAhnJmsEHnZd68FNh7UWdYVkub4j2TEGcOj00j/np1LSTEu27Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8YBtVQm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3114b7e89a6so1613440a91.2;
        Mon, 26 May 2025 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748309970; x=1748914770; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VDNozsrR2jSMsPeRLEsbQiSRT/gvBoqtxW9ncqMDN1c=;
        b=h8YBtVQmb6HO187nzbE67h+N5HzMIuuz3J/8/qb8ywtwtbweNRYF+2koorB7kcH+YL
         nhJnyE+FZvZd2qREv1ti52Bo5VzaA7wtl1a0snxDUdZiZWao8MuVSd26aIyOrBucJFcs
         Bv3Qx7DJBBf5npmeLaGyHeyRy/NrGFQHUZds+5Nx4ccZGu93j1DZIxzHsp8XMpXFGLhC
         Lqw6wRSeqtF6LMEyG/AjVBjR33rzRTxfCPG8jREvK5RPY1Q+nNhJbt5v2kjsAEyFAflW
         BQpwe7myeSB25nWUoUtjFZGoeA+AKyKKQlQG1yQbTkYP8e8Cz8t05E+vVlGuB5Mu8/Y3
         kdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748309970; x=1748914770;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDNozsrR2jSMsPeRLEsbQiSRT/gvBoqtxW9ncqMDN1c=;
        b=gDLgnhjOQp7Y4qGG7RknF07nimv8kjZ+Q+Kt5VpU3m6NUHkgnhv13hE+TFxO4yqmQ6
         nOemOVZ5+5Gc4CwRBl8z+czbjvovScHHv3pHN2KKUwykCVmgsGCB4aoleJbOROTSUqRr
         j8gLnoxxzwGKUR/Pmc8acehtGp5MlTVGSXZkbj0QhJvNle5BPJ4mCjUK2kMIit4uyjbp
         UUC20M6eyr3D36LKw82T3jHvvF112yJiJtiwrwf/Sw1f9DsV44F9ZFxCKDiioD4v3s9+
         epVTn4vzyIlEFbNFUuUkSisSv/V6c1LH87bC0c3dmxVvMs32P4Qek4hvNu4UWtRKLmP3
         kOew==
X-Forwarded-Encrypted: i=1; AJvYcCU+WeOcgOMUIn6ywlRhOM5Nm2DTfsc1TReCB6xmyj/RieYGYoxiML8Zfd5GmhYvEzgunRwn6iBrOGzD@vger.kernel.org, AJvYcCUEWmLSfYlPu3Wq5A0OY9CQGuGc1mmVCP28s9jj8Q39jDaRpIypoPbU7TWfYQR38MBqEXSvCIiC80+Y@vger.kernel.org, AJvYcCVj1afLeEcNvHp1nV1+Ty/jekcK8T++dxFNKOcZTdNrwWOXZcw4dEmPXdZd0TD9OZnHtr5UsnYbemVEXJVj@vger.kernel.org
X-Gm-Message-State: AOJu0YxKkHFtAFtmzqYQWWm1KVuDyty8WJB8txSWAjcMv3rAKSHyV4ln
	1fNfv4+tR0kNtY1KfWkUgmGlSufAlsqPSeYOEy0vPCpvFy5EPEGh009b
X-Gm-Gg: ASbGncuII0PBKQYawMwRqZmKHV+C0+XZOPstQ6/SxD1Me2bZK6W9pl6jc4yXSHnAOZE
	BtBZsj6DOKNoANKmtmVNVdf4Po5Cj5QbYWECOMZIZX7lFelt+gyeHMPiNgo4LWszzUjXX4nwch8
	cBmXtXUXuUoYSvlJOw79X8cJx53AsjC7fmgFJQ+lLGBZZ6Wj+4uCN/noz87aRIcoTHaCXbBop9a
	fpvJj83zhs4XKZbXzKHA3gZQUcRnkuS/PbJXrj9xbCel+eOOsepEPjJogd3vKgoRa9GmFzQT9Va
	zLLJpFi5N2CTcB2wcMUBgz2aqDznKepK31qfy4waBT4XHrbAyRW7
X-Google-Smtp-Source: AGHT+IGzgYNAetOKbrBA2x3zjBOyZOtZdfZqboKJVQp5aeYbfVjV0GoXSJ34C2w9Vc7NbtGJRSMbww==
X-Received: by 2002:a17:90b:19c6:b0:311:9c9a:58dd with SMTP id 98e67ed59e1d1-3119c9a5c6cmr2714876a91.13.1748309970134;
        Mon, 26 May 2025 18:39:30 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30f365f3487sm12933296a91.42.2025.05.26.18.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 18:39:29 -0700 (PDT)
Date: Tue, 27 May 2025 09:39:27 +0800
From: Longbin Li <looong.bin@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] pwm: sophgo: reorganize the code structure
Message-ID: <srj5sbjuxrbbdyl7rk553ya2jm7icujdxvn3ecrcdh5enu74ze@daedkuqpc2g5>
References: <20250428013501.6354-1-looong.bin@gmail.com>
 <20250428013501.6354-3-looong.bin@gmail.com>
 <l57yh42pb7cfbnk5z4zo473vb5pac6t4hnpg36m3iph3og4wom@kmd35myokcgp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l57yh42pb7cfbnk5z4zo473vb5pac6t4hnpg36m3iph3og4wom@kmd35myokcgp>

On Mon, May 26, 2025 at 04:59:34PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Apr 28, 2025 at 09:34:49AM +0800, Longbin Li wrote:
> > As the driver logic can be used in both SG2042 and SG2044, it
> > will be better to reorganize the code structure.
> > 
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > ---
> >  drivers/pwm/pwm-sophgo-sg2042.c | 62 +++++++++++++++++++--------------
> >  1 file changed, 35 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> > index ff4639d849ce..23a83843ba53 100644
> > --- a/drivers/pwm/pwm-sophgo-sg2042.c
> > +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> > @@ -26,18 +26,6 @@
> >  #include <linux/pwm.h>
> >  #include <linux/reset.h>
> > 
> > -/*
> > - * Offset RegisterName
> > - * 0x0000 HLPERIOD0
> > - * 0x0004 PERIOD0
> > - * 0x0008 HLPERIOD1
> > - * 0x000C PERIOD1
> > - * 0x0010 HLPERIOD2
> > - * 0x0014 PERIOD2
> > - * 0x0018 HLPERIOD3
> > - * 0x001C PERIOD3
> > - * Four groups and every group is composed of HLPERIOD & PERIOD
> > - */
> 
> This seems to be still correct? Why remove it then?
> 

The following "#define" has already expressd it. For clarity,
i will add it back.

> >  #define SG2042_PWM_HLPERIOD(chan) ((chan) * 8 + 0)
> >  #define SG2042_PWM_PERIOD(chan) ((chan) * 8 + 4)
> > 
> > @@ -53,6 +41,10 @@ struct sg2042_pwm_ddata {
> >  	unsigned long clk_rate_hz;
> >  };
> > 
> > +struct sg2042_chip_data {
> > +	const struct pwm_ops ops;
> > +};
> > +
> >  /*
> >   * period_ticks: PERIOD
> >   * hlperiod_ticks: HLPERIOD
> > @@ -66,21 +58,13 @@ static void pwm_sg2042_config(struct sg2042_pwm_ddata *ddata, unsigned int chan,
> >  	writel(hlperiod_ticks, base + SG2042_PWM_HLPERIOD(chan));
> >  }
> > 
> > -static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > -			    const struct pwm_state *state)
> > +static void pwm_set_dutycycle(struct pwm_chip *chip, struct pwm_device *pwm,
> 
> This is not a global pwm API function, so please stick to the pwm_sg2042
> prefix.
> 

I will modify that, thanks.

> > +			      const struct pwm_state *state)
> >  {
> >  	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
> >  	u32 hlperiod_ticks;
> >  	u32 period_ticks;
> > 
> > -	if (state->polarity == PWM_POLARITY_INVERSED)
> > -		return -EINVAL;
> > -
> > -	if (!state->enabled) {
> > -		pwm_sg2042_config(ddata, pwm->hwpwm, 0, 0);
> > -		return 0;
> > -	}
> > -
> >  	/*
> >  	 * Duration of High level (duty_cycle) = HLPERIOD x Period_of_input_clk
> >  	 * Duration of One Cycle (period) = PERIOD x Period_of_input_clk
> > [...]
> > @@ -123,13 +123,16 @@ static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	return 0;
> >  }
> > 
> > -static const struct pwm_ops pwm_sg2042_ops = {
> > -	.apply = pwm_sg2042_apply,
> > -	.get_state = pwm_sg2042_get_state,
> > +static const struct sg2042_chip_data sg2042_chip_data = {
> > +	.ops = {
> > +		.apply = pwm_sg2042_apply,
> > +		.get_state = pwm_sg2042_get_state,
> > +	}
> >  };
> > 
> >  static const struct of_device_id sg2042_pwm_ids[] = {
> > -	{ .compatible = "sophgo,sg2042-pwm" },
> > +	{ .compatible = "sophgo,sg2042-pwm",
> > +	  .data = &sg2042_chip_data },
> 
> I would have expected that checkpatch doesn't like that. At least I
> don't. Please make this
> 
> 	{
> 		.compatible = ...;
> 		.data = ...;
> 	},
> 

I will check that, thanks.

> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);



