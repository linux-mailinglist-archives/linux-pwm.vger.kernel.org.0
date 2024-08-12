Return-Path: <linux-pwm+bounces-3007-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534894E6FA
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 08:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8221C21C31
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 06:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58A15C143;
	Mon, 12 Aug 2024 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBuT0OHR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D815C12B
	for <linux-pwm@vger.kernel.org>; Mon, 12 Aug 2024 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445000; cv=none; b=t7JGtUpXoNgZWCmccLalKAJHegH3JwMU7UQsbqIDOHjY/ugCK9uCSJUwUqFyP2Qpy2CnKceZqsxh8K2lgesPCw9joVtzzAH4C6gMhAvUpEb1N/3N4ODdw7E9q75yMILnj5XV8/gEA7Vuy9WEZVtEx8gx4HeqhB1HEp/H3TfUs/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445000; c=relaxed/simple;
	bh=y2rTkK36HSBOLJ32CSLLN6vZXBG8wpeB/uPQHcQRFws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A/K9/rjn4hTFUbY1bGjD9Il4rcQ3kJKZo5Qpi7HdK74H3CuMkniPQx4E6n87Rtvg8yWukNQnhKteqHE8XfwBA3HIl4cyVnCabQU2ansLFbnCBOjBznNrXUiFS+FxLTxKaWQKC1zNUnSWNe5r/TG0fUGBmQwe0vB4P4JVLXmINg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QBuT0OHR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso3862473a12.3
        for <linux-pwm@vger.kernel.org>; Sun, 11 Aug 2024 23:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723444995; x=1724049795; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lbk1v6Dq8H0stWDfbtbWzC1hgrGf/GYDIFM0FXly8S0=;
        b=QBuT0OHRlUxlwGKjEp+lmA9GZDvHNh+4r+RbW/w/K1Ky/93dXfNSEpCjz+bx9KVCtm
         7qq0SPhP0QZZfnxkZHF8fGxrMoz+wwqRl5C0ekYIp7sHh9q6m0dohp7SVC0nvLfdGSJg
         7vrhT8RGxK1E7VhTRUL9LbK2u3+RGZTY/uTji3lcsaKHtv02IphhS2ninZLhMB9FH5nl
         Wjd83uoGnWvcOQjvBdCraszk47KLSLpSN5GXLKYfENsVd3yDVC50S+Sx3erIt+RD3h2l
         nsGhemR9nUX0NFDcH/3WOc6DVCIoMi0755rD5guvDBfDblscodW806p5z7PCmrmc3Pbw
         bNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723444995; x=1724049795;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbk1v6Dq8H0stWDfbtbWzC1hgrGf/GYDIFM0FXly8S0=;
        b=i+NhHbW62jCIWfa2jHoYLZOQJY7okDNOAVR/vlAEkkOELUbyhP10ZPvimrTsyZnXyB
         QN3eqLy9UGctVLWHvEyQlARuXJ/9SPWl6kE68WnMUjipVSOn/fei3PiTYJD4a/WYKrOQ
         NlPmkLPaGUWQbgUhWHYKS2HxwXJNGe3XqYUwnB4Yd2QefFSWCsCEhlHdkhguY1HXwkqJ
         Fzq3GH9feU2E2yahHcdsC9FlEXK7sXv+x8ZS+L+vwrDvaZoFQ0IFONl9pdHeoK1ZZAhy
         cgGCQLs3tGx+PJ55MYFMnoWmB4tmVAHwof384tG+4HwtK5fRSZmJ4/2inDh6N2l7N8fr
         UMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxdhs4PXPWxYFBsWrNh++pPtvxg41FGydclXKhz1FyORfkH0nQE2D3dnynqdt1WNJEzjdWXObVhs4z3C+7jt1BLOl2hFwYD7az
X-Gm-Message-State: AOJu0YxlDcBnschkoqyvrAVwOsHhpbTJKNK6B9KLh2Rx5s3tmqqGnW1y
	WEDnAtBc9J8+iJlhV1FbCqhYcPCOQMnoekZoc1HhL5B8PLeh09q/vZZ09Lr7P9I=
X-Google-Smtp-Source: AGHT+IHdlRAn61sJCLGJXEbG9EdnA7ugHPcm4jgWJ7ruc9zVraAFTLGMOKHsOinX3VlxmZmUEw8fYg==
X-Received: by 2002:a17:907:ea5:b0:a7a:929f:c0c2 with SMTP id a640c23a62f3a-a80aa65ce8fmr633287066b.51.1723444995569;
        Sun, 11 Aug 2024 23:43:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb24246fsm202385566b.203.2024.08.11.23.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 23:43:15 -0700 (PDT)
Date: Mon, 12 Aug 2024 09:43:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] pwm: lp3943: Fix signedness bug in lp3943_pwm_parse_dt()
Message-ID: <5e74df19-4469-4a10-8b87-e918769a2f9f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "num_outputs" variable needs to be signed for the error checking for
of_property_count_u32_elems() to work correctly.  If the property is not
present then we're supposed to continue, but in the current code we will
try to allocate negative bytes, which will fail and it returns -ENOMEM.

Fixes: d6a56f3bb650 ("pwm: lp3943: Use of_property_count_u32_elems() to get property length")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pwm/pwm-lp3943.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index f0e94c9e5956..803ecd6435cc 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -219,7 +219,7 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 	struct lp3943_pwm_map *pwm_map;
 	enum lp3943_pwm_output *output;
 	int i, err, count = 0;
-	u32 num_outputs;
+	int num_outputs;
 
 	if (!node)
 		return -EINVAL;
-- 
2.43.0


