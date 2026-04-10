Return-Path: <linux-pwm+bounces-8544-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGaFOvjP2GngiQgAu9opvQ
	(envelope-from <linux-pwm+bounces-8544-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 12:24:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9D3D5A26
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 12:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8543C3006F16
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Apr 2026 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D937C92E;
	Fri, 10 Apr 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N22ioBIM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9337C109
	for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816672; cv=none; b=LUSNZiGDszX7SXbTcVvm9ubl6rhXQ9DTvaDOzh+Qx0pwewO8IN+FkHeCdDlofBxrI9UceS4/JAl/YGviJMr+xzRnsu7o6Zhp/OjG7u15/cT7VRSwUNrdOMc77fmCTDEx5qro+v32c/S0b010TkYlPx2h6iZY1cjBD29NtLSZ5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816672; c=relaxed/simple;
	bh=xe5BlvWEmvuJ0r8jiIZC9Qt6O5+U0xuQTEj7QAoXSxA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHxRh7BY0yhqTcHO/2a9erSsEhmL/D4FfAnUYZw9k1fENUcwLlEwW8N/C7RSxjzqtBp4aZR6BAwHcwXtUEgEhbDOLnF45WQN02/9cEJwrvk5FlJ5r+UbbSjwHEV5b5fMkmetRMLevmZ5OlpvqnZN8H2bbc62Uuaq8UsFoFYuppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N22ioBIM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso1470283f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 10 Apr 2026 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775816670; x=1776421470; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKnPag+J1FK879lrPixqSysMm2rbphTSL3HqF/0DRQk=;
        b=N22ioBIMsFLNgTbEmrA5vN8oKPwMYWkVy1y8v7my5f3kB6ez+n2+0pS6ccJMv37w/+
         biEJg/KuGgcnMXbnQYiYnDU5DKLGsTekqm022Tmz9RvMTDLcr277RpgC8vq6FcYxcBJl
         shxJ7LBr5hDtPN9mm/2Ofn0p4ZW+lDw5aufanq1Z7bL6TfzqVtBADIHcnNvPgPuqq/wq
         dNKIR2hhUlJk8uyQMNpOcsB5fIYijnctWCnwlAM7gZTZ/6ijtc11rgsCJ/9dkZiVHD0x
         4NFaWhfsd2sHSVunW3DGZd30Lq2sxkh7s0Wd433et7af55cgj6glpiwEMP/Y6u1SMHQV
         FCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816670; x=1776421470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKnPag+J1FK879lrPixqSysMm2rbphTSL3HqF/0DRQk=;
        b=PufRw2OhEBzsNoZYtlM7LoH5/OSOPyD8KfWH2LSUdLAjrMrpA2YPBv1D1OH+CPgU6y
         aJrPenYqOjp7Eeu7bgcyzsNxm0FqaEYReyW05kXjFgZoavRm6qDYe4aVKnsKwtYQOdkK
         92cQQdKy1enyWO4jeAqEMyfPopZz0QS8wqUYPbEI587HHVG1Ifi+forqY5Zs6X3GSQbb
         izzmM/bUgJswSjKm1d4wdSPdOk+0UZFqvZxMrgzZi2SFaFQtffFICiLJ6y3zcWMw+dYF
         YTqX706WcMa5NIj3IIdreatQ3oIiP4zaS/QP/IfKXUU1yzJJU5iIEgsTVt9LeTDW1tWY
         LJQA==
X-Forwarded-Encrypted: i=1; AJvYcCXNdcK3VMaC4RfHDK4BBkXFTKagNBavYs2fbHxhLVbfy0Bgk0Cz4syOfgiGLIDdXRmRiG1DUdyd4JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0vrH1ZfxlKrW4fuv8pTjWXficoD2Oey+ZNL4hxFZIlXKQlir
	rZ5ZmqK5HqC93UAgwHN+xaSGfHlKwXAJPxF344UsVij33XiXcQ5TGpAy6RL9v9XUF2I=
X-Gm-Gg: AeBDieuWGJAdzGyXs8ci9z6lynWylzkvsh3XWvhzxLYmtHKF5obOWBPfXi1d13h7SeI
	bc+xPyLh+4QqDy9iozIbmWzjKytxgb6gW75nFewF44HAVW2rGtA6MAV1SeNAsc0astgnErOUnMA
	I4ziLCHLrhQS1RnDmhlZVdyPc47mIrDwP4upu5NegkjxFGfHWku7OPBZjC+7HVeOMsDUHTBXVnK
	OayMZb6mjjHkZ43M38EGKqAZIVnanbo11UPQNe1PsJdLjQwD6/3OnSX+LzB25dUieQzItHwtzE9
	pT6kWvJ6VcMBttfV+99a1t8TlMf3HUP6XlNZkB0enY1/CkHwCJ2gdo2rSqGIZg15mF84NlfMwzU
	CVK83YPU+EMkqPv8UNwT7bxal6hWFay8s8HZXv00BENcTaq9JcvDiIVS+jqtvPPbW2H2c2zTE2g
	EZMe1wCGudEBPIbkxle5sbkdN5cJKEVZNisO55+kfcnZKRZHFPdg==
X-Received: by 2002:a05:6000:402a:b0:43b:8f23:a87b with SMTP id ffacd0b85a97d-43d642d9d59mr3841629f8f.44.1775816669353;
        Fri, 10 Apr 2026 03:24:29 -0700 (PDT)
Received: from localhost (93-41-3-120.ip79.fastwebnet.it. [93.41.3.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm6454744f8f.33.2026.04.10.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:24:29 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 10 Apr 2026 12:27:35 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, linux-pwm@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <adjQl37-6a--_y3Y@apocalypse>
References: <cover.1775223441.git.andrea.porta@suse.com>
 <28e29fbfc20c0b8a115d006233c2759d8f49e639.1775223441.git.andrea.porta@suse.com>
 <adLTwOTbkJ0VQXy6@monoceros>
 <adfQ6Tvst3Vd1Mxe@apocalypse>
 <adiW1tBC8Imd14LD@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adiW1tBC8Imd14LD@monoceros>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8544-lists,linux-pwm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 65D9D3D5A26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Uwe,

On 08:27 Fri 10 Apr     , Uwe Kleine-König wrote:
> Hello Andrea,
> 
> On Thu, Apr 09, 2026 at 06:16:41PM +0200, Andrea della Porta wrote:
> > On 23:45 Sun 05 Apr     , Uwe Kleine-König wrote:
> > > On Fri, Apr 03, 2026 at 04:31:55PM +0200, Andrea della Porta wrote:
> > > > +static void rp1_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> > > > +{
> > > > +	struct rp1_pwm *rp1 = pwmchip_get_drvdata(chip);
> > > > +	u32 value;
> > > > +
> > > > +	value = readl(rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
> > > > +	value &= ~PWM_MODE_MASK;
> > > > +	writel(value, rp1->base + PWM_CHANNEL_CTRL(pwm->hwpwm));
> > > > +
> > > > +	rp1_pwm_apply_config(chip, pwm);
> > > 
> > > What is the purpose of this call?
> > 
> > To update the configuration on the next PWM strobe in order to avoid
> > glitches. I'll add a short comment in the code.
> 
> .pwm_free() should not touch the hardware configuration. Changing the
> pinmuxing (which I guess is the purpose of clearing PWM_MODE_MASK) is
> somewhat a grey area. If that saves energy, that's okish. Otherwise
> not interfering with the operation of the PWM (e.g. to keep a display on
> during kexec or so) is preferred.

Sorry I should've been more clear on this. The pinmux/conf is not changed
at all by this mask, only the PWM output mode is. The controller can output
several type of waveforms and clearing PWM_MODE_MASK is just setting the
controller to output a 0, which is the reset default i.e. the same value
as just before exporting the channel.
I guess this is the expected behaviour in case of a fan, it should stop
spinning in case you unexport the pwm channel, but I see it could be
different with displays.
Honestly I don't have a strong opinion about that, please just let me
know if I should drop that pwm_free entirely.

> 
> > > > +static int rp1_pwm_resume(struct device *dev)
> > > > +{
> > > > +	struct rp1_pwm *rp1 = dev_get_drvdata(dev);
> > > > +
> > > > +	return clk_prepare_enable(rp1->clk);
> > > 
> > > Hmm, if this fails and then the driver is unbound, the clk operations
> > > are not balanced.
> > 
> > I'll add some flags to check if the clock is really enabled or not.
> 
> To be honest, I guess that is a problem of several drivers, not only in
> drivers/pwm. If this complicates the driver, I guess addressing this
> isn't very critical.

I'll come up with something, we can always drop this check if deemed
too 'noisy'. 

Many thanks,
Andrea

> 
> Best regards
> Uwe



