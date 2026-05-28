Return-Path: <linux-pwm+bounces-9190-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EGINKuEGGq6kggAu9opvQ
	(envelope-from <linux-pwm+bounces-9190-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2026 20:08:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627995F6197
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2026 20:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51D44300F962
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2026 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A5405C4D;
	Thu, 28 May 2026 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JcGJyA2a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84849403EB3
	for <linux-pwm@vger.kernel.org>; Thu, 28 May 2026 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991590; cv=none; b=c97ugn3QH1E8AmkEYukxAqOLEaPN+qGgvk/x0Xz3iFgZzX0EJWhPvyN7bdDja3vI7VpQQUNhUeTvk/gKc26za3ZdPsvntPDnCkPPzL+xaSvC75fC8vRK6Fz6M7gTAIAdfOHw2KOzOGrIkRKzjOd0L76Bjn1A6VBDQb+egJg0de4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991590; c=relaxed/simple;
	bh=af73kpAYk32HU4/KrqRaCsdbO3x5f+QppyEA0uuLqJg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdciPnrfKwtjZY75N/7J2wAN8VdAMPvfuy/d0NiCwmDfmCAkctQ24luUWe6eS04DgODEyiz23Zpw81MUEvHAlzQ1XtlOCoYbK42Nci2zvjEtAZ2Nl6q1iGRCqc+cF6vWGs8Xg11yK/wyhlwu9g2KAXfaq0G0EsbckpCUisfOAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JcGJyA2a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso53387875e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 28 May 2026 11:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779991588; x=1780596388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HjBnDhcN8xwPKgx08Kq8ygn56aIVDiT8Tf5r5T0cRW8=;
        b=JcGJyA2a0z5EF4zlGts5D0LUl/LDG9oPgvCzUHu6KyB0hKP4LLyCoL6U/HmWu9a3QQ
         mzRl21mf4vE/Fc616Nvh8v+BX0nGGRuW5prH9A/gP3mzXJfY0TmxJaP5rrtAtF++DgKz
         i2ua3hgVQUzTfA35hZ2aX99g4hSBhxzUZsdSghVcYJfYpeApn9JRRcvFLJdT432WpOcP
         rofGG8E56MeB96A9BcWeRhy+EKn/VXUaetjeveJREPVugsRQYykFjUWwameRUzzd70R6
         lnzbH5OzXdTD6jO2CpJhUcAKxEa/OKdI+NZhmW4uSj0YoUL6BOPKc0DpiVKDPrJv8dFe
         pLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991588; x=1780596388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjBnDhcN8xwPKgx08Kq8ygn56aIVDiT8Tf5r5T0cRW8=;
        b=GPiVsazf2OzfD71q8rxRN/LE1HglrUPrpqt5gqth8nUJm953syWPW6hqN2TQBjKULI
         vbz7g/NxITldvoxlrtPdDPZ5i6N+GYzl0M0ensgy+JypAE++ru81kNYMLioti4xkofDo
         AOHFOIk7krIuJ0BpDtSPkm7gTQGeJmXdM6t0/iyYqaVl6n+4Dj7LN45PK1mWlWtXbHTw
         mzNKOtlsODuuxnD6WA19xgGXKWUytA0rFhzGl2l19TiVkmNpBmxb8Obj9APLxgDb35Ke
         XIv6QN0MRsT+qKU/0lMEELD3h3NIVICzMxTDotaa+QL4s7dcjC5aaW1Pq7J5A1RmrBTU
         6eOw==
X-Forwarded-Encrypted: i=1; AFNElJ/SI5yGEmxGJ2DjUYohfk+MIbVueEcmKlv5L4mndiy6aIk00QedpqAZRrScMudDSHZqHBCa0ALpbrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjTqp10Wfs8UI6Mqxcpvaat5fcSlUchjXgkr5tsO37DmI3nEU
	GZxZfkwxNQIyyOLWNpfXGaFLBHXG8JUKlbK6CZUiU9HlDSA6jGg1vWTAuxKaxuYxYA96mfknfr5
	gc2j9+T4=
X-Gm-Gg: Acq92OFro/+xpMrJ5xDgBC9w0SXedsgM4f71zbvxCX5gA/2FcIzlb8VjuI1Wv/PtXp7
	Gr/rT9tCSkUYfFW9ClIyFbhQmJ4+h33xdUqqBENnOftpghLMBUukxp/v8riVWFM1FwI6cYb23OW
	rRKU/hxKmAoc6bKt8TTi8YzlSU5bDj67mT34OXIlaYj/ECG6KExRcv+j0J91HTYaa/yW6EcyIor
	m/6h2D6FHb+GUP6ulP17I8vA4JhWbC8uYdsQ+M1So7meqx7HtA9x4A3aa0fMABOYykPw+PfXTpg
	A0Is8OjoZ1lHF1RXcT9omUncHvO7OGRhUR9zcOzb7BztpfnfKW+wV/BJTQtg56Ta0kZR9/vPvxB
	sOEKZgBLQePM0Af0IlTh7Pi7IsjZhmMiPcSPSd/cylNUpOe9iWkNjNrvDnQzYOGUx6nK+pvL2aU
	rJDEzCjenLg2cRvJf/gqTNg4ZKn6bbggw+8p0id9LVz8aE
X-Received: by 2002:a05:600c:1992:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490426bc7dcmr456146915e9.16.1779991588018;
        Thu, 28 May 2026 11:06:28 -0700 (PDT)
Received: from localhost ([194.183.24.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909a23daf5sm1264145e9.3.2026.05.28.11.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:06:27 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 28 May 2026 20:09:47 +0200
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v3 0/3] Add RP1 PWM controller support
Message-ID: <ahiE63mGZq711FXg@apocalypse>
References: <cover.1776932336.git.andrea.porta@suse.com>
 <af2bsEdAhYY9c4rb@apocalypse>
 <394b5e02-1aa6-4efe-a5f7-4468d1f82172@broadcom.com>
 <ahajNRmYNa5SNQnS@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahajNRmYNa5SNQnS@monoceros>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9190-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 627995F6197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 09:55 Wed 27 May     , Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, May 20, 2026 at 04:31:42PM -0700, Florian Fainelli wrote:
> > I would prefer to take the DTS changes through the Broadcom ARM SoC tree to
> > minimize conflicts on my end, are you going to take the PWM patches for 7.2?
> 
> I didn't find the time yet to look in detail, but skimming
> https://sashiko.dev/#/patchset/cover.1776932336.git.andrea.porta%40suse.com
> suggests that there is still something to do for Andrea.

Right, so I guess a V4 is on the way soon...
specifically, about teh DTS, I will rename rp1_pwm to rp1_pwm1 to differentiate
it from pwm0.

Thanks,
Andrea

> 
> Best regards
> Uwe



