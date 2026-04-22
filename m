Return-Path: <linux-pwm+bounces-8668-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL5MGldU6GkcJQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8668-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 06:53:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CEA442066
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 06:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E6A305580B
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Apr 2026 04:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3672652A2;
	Wed, 22 Apr 2026 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="G8K0zuPy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A0277007
	for <linux-pwm@vger.kernel.org>; Wed, 22 Apr 2026 04:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776833387; cv=none; b=LEmxtxojnu9YDZy9YBqV1ZSluwSH3j9DDUyffaJbjPAz5EbIYmrHeqbESAm3ZvUbBbOw7fCqL1zbBTSFy80A1SV9EeGr4wOVkzoLtqwLMN+WvTrbUNHgD1Zyv7AlqBJ269A4pduxgGwql4zC4SVRfojLnqYIDKHyBMC6EFWbRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776833387; c=relaxed/simple;
	bh=amoFYOXNj6ai1aoDXuC/QErgGvTREL0GtwLWXrsqXcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGIwkr96dotw3YDPtiadc6DmS8dnOOx0xM1Qd1K6stamlO59sOQ5PvPu5gcSQYQXnAo3GpZnEYH3qoOsLsofRPEqvwmigG23OVOl7/ZgivWvH/N1l5mrSyKiLWo+l6bNgda6q6b12g8KRI9lPbe7E6KQbAbXhj63/LJAvr4agoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=G8K0zuPy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b23fcf90b2so48265585ad.3
        for <linux-pwm@vger.kernel.org>; Tue, 21 Apr 2026 21:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776833383; x=1777438183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9eH4zus6aRXEsE79ZbJPuyaxQ8dOTtTmwWEdDWPv4Bs=;
        b=G8K0zuPyRoYkvUe1EhM8NUBt1tHMZNeAVQzrApmScGaRhFM7njB6UGnaiwfwgjAmOC
         CM73MJ+rbWI/NlfQLPlC7w4OxNmWIlX7X9NVAyUEiqmLc542HHFo2nkiuN4fSCkHC/uE
         ZFe0ocnFcZvmT9r1j3UIMsYh4NgRt3RkXEwE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776833383; x=1777438183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eH4zus6aRXEsE79ZbJPuyaxQ8dOTtTmwWEdDWPv4Bs=;
        b=X6h6ox8A1YhO1mXernxYZssiF2m1j5Etaqu+kStOuE46JZIUjc3tNUMQAWM7A1v0Vo
         sg6fGIMzQHrsRUJCH1eZtla9q0iIGs7DGDVX5brSkFxOmw3lkLv7VNWDfTlzVZlImraq
         rqDx04dnd/QsGy28J3ePpvqkCRGwHfv1edDXmT4cI38vcnyRkdX+JJk35UowXTjh9FmL
         gQrTlM74nX7h4hL79Pvz/e4Gk1tWmwFmezqvnipvz51sat9hY6PTrUQjuIK7r15KOrKK
         emA9FmzrXznq9m8LXMImPxd1CbmbF+Ex/qiPodcGP2j21S+qMNltnVCdN79WErQfY0gI
         w4yw==
X-Forwarded-Encrypted: i=1; AFNElJ80sg5lo9ogfRo69362a8Ffq9Fw2mmdMEv49Ky/33nVkskyEQcZMxex3B+xwzQWpBRhr2zOIg7b7ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbvwNV2uvIZviNETcFJQP4oyvRHMNE6DRti0/E+mMGN+QSy9B
	tVYdEyf0Dz4rWCCDbcKCS/9v+71iG4j7deMxAcvgCm+0PnZ/gv0OtFbXikGL7JTMy54=
X-Gm-Gg: AeBDiesfG8r14o/iLmCoW9pp+pHnKE8Gxmj8Zo7WRzUyXx8N1Vco1VVkBgTXovr9rMv
	tAIzRpCexUd6wmuFGDwR4xKU23ROzmy3YNsShnd9FW+4gl0DVYP2cfx0P/XzE+oJ0lL26OElCfd
	yedmG6XWcUbmqCJ5EZBXvFBahe3rMtCClnleQGV5FsF6H5e7MQQq2iFP9G0LmRAVFyUUqjR+eNp
	CduntMz57ZqvszEuDZVLzlOpH4tsmvNE1uK5jkH8x0Be4RZLaxVi3Y4GHT+fZIq5udQ4xExsf9K
	E2zBT7zrgbTOXUgWnw4ncXoEv9aCcez0+W3sVNGWTk3flBib53VtiZ6PqL6MapFw1wwPlZMamkb
	FvQxIvV9ndW2/uC/8Pfhq6t9Y+ay4sja9OSD4ogmaf6aLTpCbajJI+ci27VWQ+wwRvLEGELsGMy
	ApK2g6VGXuTrUzhCvxBBtQqum1pf9sCTlVKLKlR8GwUVCACcJgXMoFVIQRYbVeggu/nb7jJq3fv
	w==
X-Received: by 2002:a17:902:f9cf:b0:2b2:50e1:f104 with SMTP id d9443c01a7336-2b5f9e64c18mr142624095ad.3.1776833383473;
        Tue, 21 Apr 2026 21:49:43 -0700 (PDT)
Received: from localhost (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab208d4sm160434605ad.55.2026.04.21.21.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 21:49:43 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:49:40 +0900
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: atmel-tcb: Cache clock rates and mark chip as
 atomic
Message-ID: <20260422044940.tse3ek7jlv3x2dbt@nunu>
References: <20260415093433.2359955-1-sangyun.kim@snu.ac.kr>
 <20260419080838.3192357-1-sangyun.kim@snu.ac.kr>
 <aedfEzeRH5tH0-Fb@monoceros>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aedfEzeRH5tH0-Fb@monoceros>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8668-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sangyun.kim@snu.ac.kr,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52CEA442066
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 01:40:55 PM +0200, Uwe Kleine-König wrote:
>Hello Sangyun,

Hi Uwe,
Thanks for the review.

>
>On Sun, Apr 19, 2026 at 05:08:38PM +0900, Sangyun Kim wrote:
>> @@ -438,16 +441,33 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>>  	if (err)
>>  		goto err_gclk;
>>
>> +	err = clk_rate_exclusive_get(tcbpwmc->clk);
>> +	if (err)
>> +		goto err_disable_clk;
>> +
>> +	err = clk_rate_exclusive_get(tcbpwmc->slow_clk);
>> +	if (err)
>> +		goto err_clk_unlock;
>> +
>> +	tcbpwmc->rate = clk_get_rate(tcbpwmc->clk);
>> +	tcbpwmc->slow_rate = clk_get_rate(tcbpwmc->slow_clk);
>> +
>
>Only one concern left: clk_get_rate() should only be called on enabled
>clocks. I don't know the architecture details and how expensive it is to
>have .clk enabled (or if it's enabled anyhow).
>
>If you're ok, I'd squash the following diff into your patch:

That makes sense. clk_get_rate() should indeed only be used on enabled
clocks, and your change is the simplest way to ensure correctness while
respecting the clk API constraints. I’m happy with squashing your diff
into my patch.

>
>diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
>index 1a2832f1ace2..3d30aeab507e 100644
>--- a/drivers/pwm/pwm-atmel-tcb.c
>+++ b/drivers/pwm/pwm-atmel-tcb.c
>@@ -437,13 +437,17 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
> 	tcbpwmc->channel = channel;
> 	tcbpwmc->width = config->counter_width;
>
>-	err = clk_prepare_enable(tcbpwmc->slow_clk);
>+	err = clk_prepare_enable(tcbpwmc->clk);
> 	if (err)
> 		goto err_gclk;
>
>+	err = clk_prepare_enable(tcbpwmc->slow_clk);
>+	if (err)
>+		goto err_disable_clk;;
>+
> 	err = clk_rate_exclusive_get(tcbpwmc->clk);
> 	if (err)
>-		goto err_disable_clk;
>+		goto err_disable_slow_clk;
>
> 	err = clk_rate_exclusive_get(tcbpwmc->slow_clk);
> 	if (err)
>@@ -469,6 +473,9 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
> 	clk_rate_exclusive_put(tcbpwmc->clk);
>
> err_disable_clk:
>+	clk_disable_unprepare(tcbpwmc->clk);
>+
>+err_disable_slow_clk:
> 	clk_disable_unprepare(tcbpwmc->slow_clk);
>
> err_gclk:
>@@ -492,6 +499,7 @@ static void atmel_tcb_pwm_remove(struct platform_device *pdev)
>
> 	clk_rate_exclusive_put(tcbpwmc->slow_clk);
> 	clk_rate_exclusive_put(tcbpwmc->clk);
>+	clk_disable_unprepare(tcbpwmc->clk);
> 	clk_disable_unprepare(tcbpwmc->slow_clk);
> 	clk_put(tcbpwmc->gclk);
> 	clk_put(tcbpwmc->clk);
>
>
>This has the downside that clk is kept enabled the whole driver
>lifetime, but that's the easiest way to make your fix honor the clk API
>constraints. This allows to fast-track the patch fixing the sleeping
>function called from invalid context issue and the optimisation can then
>be addressed with more time during the next development cycles.

Keeping the clock enabled for the driver lifetime is acceptable for now
to fast-track the fix, and we can revisit potential optimizations in a
follow-up patch.

Thanks again for the suggestion.

>
>Best regards
>Uwe

Best regards,
Sangyun

