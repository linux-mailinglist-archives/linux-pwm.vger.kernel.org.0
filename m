Return-Path: <linux-pwm+bounces-1901-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6131B8A1E91
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC0D292440
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E714A4F8;
	Thu, 11 Apr 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXCShYsA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C953384;
	Thu, 11 Apr 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859312; cv=none; b=Asp++5RY96sY5/x3wmE5Dg6d0MFt1jOJMgBakbggHmUQCyYeAXb3kenOM8q+SkG2CIsfcKddqS6SaJYBnbj0pLVfRsNla6+vSayTEUNZZflamlLGtzLQBQ72L6Nry4tGm7VVRHbuUdSGZuBWgbno1EM66mTYdMOBU47c9GT71cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859312; c=relaxed/simple;
	bh=NVe9AH+cmQO/0WpvMso6cGw7pgNWRDGowVKBPJCqPjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THx3ZhXfC8woHsaCsyznYHWX4WSqyQZ9VwK/g3i2oYdcn6VwE5vro6IfJYuVNUGaGjXn6PlgbpZKAQtLIWOr3Fpfs3KjMGQ3zPEmr5humVg/lIta5xayAEU3abryrVCIUhfBxTTJb4aHQfi+wlU20viRZn6Jcb1WpveQdHanJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXCShYsA; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e782e955adso160645b3a.3;
        Thu, 11 Apr 2024 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712859309; x=1713464109; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nM/5Rbqc0Ko6b717arrdCr2EqTMmE2AdERSDBdnW28=;
        b=dXCShYsAgZa5D6jsbdHw5lp1ckWbuU3g9UPooDtQo3ggidEG5N3fQtijBTIWKLB06N
         PQWNct9gYBTWG5nhlMWVldurtjVsJphunt3KobPDbGjS1B1WVdn3JBSYhXoDUfvTwh5i
         QtcyLuz8EYv+aFn9UvrZMdXdE+yR3YlIPSHnS1pjoUz+jnlcLlajqvR4y4QMt7m+E8Ey
         hBGnJAt3RkcvqyzWgUxdbC2D2wA8AAUpoj1ftpKQq29CGYZPmEiHsG5CB2WGUz88pYSv
         69lF++r0xh8QHbw7vtTDXZJ5xAviba4OhUWcJh4w/JJXP1/FuG9cnPWwz4F3d7is3eFo
         W89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712859309; x=1713464109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nM/5Rbqc0Ko6b717arrdCr2EqTMmE2AdERSDBdnW28=;
        b=B+x+Cr9/Nq8O0WPliCOt+CV3F0QD4yzr+A8aKmMHqiUmWPtGX775VjFMMMq7nvbnzH
         IO69/9lUmgahqoWX0n6cQOimEDjCaCPeLoPdp1pX1fv1Pv6ZQ87ZYPHeiRtE1+Hd+2xm
         mSMNRd5vHR7mVSRtMYHL7u7Zse81JKNg12no3xGnFNzv4eDBlv66RA/iEiUQTwb1pSmM
         Cjl7GQrfPO6DHqk8Y0Kz42AVoObSvP2LtNmv/6X4b+VCcP8Raoz3cSt8pbWWVQBEtQBt
         ie+ZeGFFKIC3FDh47rDZrbRPHVPyXxXU8qJdd9oXMiHVXgF+euNRwwlqrUK5lN3mbbyL
         Eo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUu2VYHm/fD0Ojm/8IDjWHHePPuLi2IB/5xnK/bBBvWVkYBsCRuRQ59/osHOjR83MeGetD8kQpkehGniwwzvGw+3ZvelBeOrSQ271lncgvW+FKCH5zC6Ibru+3BTUEZAv3BH0lmdg=
X-Gm-Message-State: AOJu0YxyPk9/o4V0gDzoEN+Vq74ZPEmhH6OkWA+uqqJqpImeUuXfrgTX
	2tYkE0JwHiWgor3hSFZZGPMM5QAn0FExbyXrmrUfGfhrhPbtk4Kr
X-Google-Smtp-Source: AGHT+IFEkPnym5HZi/cShkQEd/EVhXm/eFprr5GSIu2VtMtV2iB90prePI/rvjZ4gAhI2103K2mCOA==
X-Received: by 2002:a05:6a00:1312:b0:6ed:8798:3fa3 with SMTP id j18-20020a056a00131200b006ed87983fa3mr538860pfu.15.1712859308774;
        Thu, 11 Apr 2024 11:15:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h15-20020a63384f000000b005dc5289c4edsm1320302pgn.64.2024.04.11.11.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 11:15:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 11 Apr 2024 11:15:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
	linux-pwm@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, kernel@pengutronix.de
Subject: Re: [PATCH] hwmon: (aspeed-g6-pwm-tacho): Drop cpp define only used
 once
Message-ID: <0787f458-c4ff-4498-820e-15e19796cbe6@roeck-us.net>
References: <20240411160136.247138-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411160136.247138-2-u.kleine-koenig@pengutronix.de>

On Thu, Apr 11, 2024 at 06:01:36PM +0200, Uwe Kleine-König wrote:
> The macro PWM_ASPEED_NR_PWMS is only used once, just use it's value in
> this single code line.
> 

I am not part of the thou-shalt-not-use-defines-if-only-used-once
crowd, so I won't take this patch, sorry.

Guenter

