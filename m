Return-Path: <linux-pwm+bounces-8355-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN70HW6Ew2kPrQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8355-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 07:45:02 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D901332049F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 07:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18C3330158A6
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 06:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E6A359A67;
	Wed, 25 Mar 2026 06:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPagIaJm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6510630AACD
	for <linux-pwm@vger.kernel.org>; Wed, 25 Mar 2026 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420972; cv=none; b=Qha2jQ1gcPDpmJJ7U8w/CeN8vHIPX8NdBlVa9T00ciNaF3MxMfaSGj2Lfjf5RjGBFM/Iq195bjF0V97/BcqPukwjFkcIqWgOM6ljK7sku/YxjO+gukDXu14kcfB++lBcO/VUcfaKHXVib4JmtTMAF8XzP/fja01V1dpBLKukPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420972; c=relaxed/simple;
	bh=PxgRccVn8cF02TlACNrcwsh3WON1Nirb5TL1ReGEieE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX0OZ/SzwpZov9jQyN6Fl0657FrIesOvjRnER0mFI5p63iWgnc/NT+fkIniFTXqNqRefbQemBA5IX2K96ZuazRuDUF1VvfVujXIyQono01ImUXdisAScT/uxRhYhgcpBuHkG0S7UjP4O37AZCffWPzGn83PMpaKPZKm9ZfrJSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPagIaJm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8298fad2063so3098654b3a.3
        for <linux-pwm@vger.kernel.org>; Tue, 24 Mar 2026 23:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774420971; x=1775025771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/6M4B+9kyrMtUcVVbXTu+8SlccYPDUcc3KdjZB1RGuY=;
        b=cPagIaJmGj/19semEx7ShU5yUUW9rl+iH2EGWhB3EQdKGhquRqdzvs3UEF6eD9Oa5y
         +oqWbXI5+AlsUs2I7/W9nZVl+Zg1P/oAtOyzB4wqYYbCw8DftL5KckkXc+eHyYcrwkPb
         ceqyh+FhWdVOXCBwuInDqlndSFCBONEADL5LJZospY8fRCoCQFSg6UxxzT1lIIPwuP5M
         m49n8gfn3ob7ttccau6j7/KSxEOkCEFi0x3A1zIrzWaL4YndJMG8NT0iQD99Z9gQQ/24
         DaTjhXHR7AYnbe3SdY/ctVVDJsv6vfgJ9xSLMAiOa4BaCNma66FGLR3DGYW7k0TOoij7
         RCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420971; x=1775025771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6M4B+9kyrMtUcVVbXTu+8SlccYPDUcc3KdjZB1RGuY=;
        b=E43vOFt5A9OwMRoeodyawKSDL2LKeqMWi3z9xNBIusl44DkKsoqCWfnVxyxtCWTrHj
         vKG/eLGoxhZAYNwZrORZeOWC3c8sOzF5zbbt4qQYArG5qSaujYmh77FqMRwIFv4BMeAP
         v4uVoIjVl6xtL6L2wp9F+XaG2J5d7ojUonWBHxgPEBuzocJHhWpV9T8gjBDOQ1uGhiZt
         szj4s/+DTcqKAxWOAgMmvu5aPDGyT0iAw7erQmAi22yVvAVAO30Hl6/zaQHkeYJyem+O
         eZvTTlfLy6jAAbXYXMfwGfBIzFcyotGRydkA6pzmLiolJ5JcX2v24DLz5yC6lPMSWcLH
         HSVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwL4F2GcwQ9BIshdn2UYpPppKnlYzqXDWIlfZZxSWnaLAUwj5H21VVTjM5MJs4+hx0fZV4BJ6hbhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CXNTJA+AD5fUOG/deUziYotoJ0gtXBtnOSOBMPd9WvXXvxyn
	KrVl+TOIvOgeGYCmxen9tHWKYuqXhbB/XXZA9lSlnlQV58WO8Ciay0cdoxrXvyurD50=
X-Gm-Gg: ATEYQzySy9G31gQLWlgQnd7Cggs4g3e4/M6r/yHuBwindHLDoJXmTfaj6+AZm2Tnity
	OMdwGPYsR6WD3DTAmuI4kLJ+c0OawOyepJ+MyIsSpaH6CQIWFp3+n4fukQnH5HfG2OSzvjHbgIp
	1YEj4lL9/0OHQ35kpIJ7m/4DjZgHsatiGP3jam8eAsIlEurlPDpu1DmPv8RIv+KU/ldrtjo/zK1
	MXEj/FcTnWZKbJw3yLmKhh7N9sCqHCgQN+RX4co3I4VwNEqHKHJLp7R1i2m236iaBb2kpA7b18Z
	uonTKx6ellbuId6MW9Uh37WUdcoV0HQPJ6f1tG97gHEZzEeshTdMP94GEyPMYb/i6gXfsiml0Oo
	H+6SaJ+UdsgF67byYXtF54waLdXtevhHatxOcUO7crrOaX6JCyOUgJAd2Ny2uPRLwfNtneCeJVa
	41Vv8N7iLmwBVOh14w6LDYTK1G
X-Received: by 2002:a05:6a00:b484:b0:82c:24a6:2a75 with SMTP id d2e1a72fcca58-82c6de79e34mr2217015b3a.10.1774420970591;
        Tue, 24 Mar 2026 23:42:50 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409b448sm14055926b3a.39.2026.03.24.23.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 23:42:49 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:12:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yi-Wei Wang <yiweiw@nvidia.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] pwm: tegra: Avoid hard-coded max clock frequency
Message-ID: <2qvafxg3umwqeshf6eag3ep2zpyfwxbcdj57iorlcrus3tzrti@cpnkeirybxxo>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
 <20260323-t264-pwm-v1-1-4c4ff743050f@nvidia.com>
 <acKggw9F7oULLEuJ@monoceros>
 <4405239.kQq0lBPeGt@senjougahara>
 <acN7pSjuMkZl2yhV@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acN7pSjuMkZl2yhV@monoceros>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8355-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,vger.kernel.org,kernel.org,ti.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viresh.kumar@linaro.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: D901332049F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25-03-26, 07:12, Uwe Kleine-König wrote:
> On Wed, Mar 25, 2026 at 09:34:55AM +0900, Mikko Perttunen wrote:
> > On Wednesday, March 25, 2026 1:45 AM Uwe Kleine-König wrote:
> > > On Mon, Mar 23, 2026 at 11:36:37AM +0900, Mikko Perttunen wrote:
> > > > @@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device
> > > > *pdev)> 
> > > >  		return ret;
> > > >  	
> > > >  	/* Set maximum frequency of the IP */
> > > > 
> > > > -	ret = dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
> > > > +	ret = dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
> > > 
> > > The documentation comment for dev_pm_opp_set_rate() reads:
> > > 
> > > 	Device wanting to run at fmax provided by the opp, should have
> > > 	already rounded to the target OPP's frequency.

And that is correct, right ? This comment is talking about the max freq possible
with each OPP and not the highest freq possible with the device. If a device
supports 5 OPPs (0-4) and if we want to run at the freq mentioned in the OPP3
entry in DT, then the caller must send a frequency such that clk_round_rate()
returns the frequency of the OPP3.

In the above case though, we will end up running at the highest freq returned
by clk_round_rate() and an OPP corresponding to that.

> > > I think using S64_MAX is technically fine (assuming there are no issues
> > > with big numbers in that function), but still it feels wrong to use
> > > something simpler than the comment suggests. Am I missing something?

I think S64_MAX will work as well, unless clk_round_rate() returns a frequency
higher than what the OPP table mentions. It may still work, but the values may
be confusing and inconsistent.

> > Looking at the history of the function, the comment was added in the commit 
> > below. It seems like it used to be that the opp framework always used the fmax 
> > of each OPP even if a lower rate was specified, but after the change, the 
> > caller has to specify the fmax rate if they want that rate specifically. As 
> > such I don't think it should be an issue in our case, as we're just using the 
> > rate to find an OPP and don't have a specific one in mind.

Right.

> So the comment describing dev_pm_opp_set_rate() needs an update, right?

Maybe, not sure. But as I mentioned earlier, it is written with the context of
each OPP's highest freq.

-- 
viresh

