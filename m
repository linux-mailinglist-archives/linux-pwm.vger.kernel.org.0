Return-Path: <linux-pwm+bounces-1522-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C585E856292
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799C71F23D7C
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ACA12C7E0;
	Thu, 15 Feb 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1RYVylI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8F12BF3D
	for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998933; cv=none; b=aO12fdIIYqG8dS5CidmaM2XiXIcB+qBil97BSZDWKZUTv7bZtiRt2MTIeaBstXg0S6v5Zt58ef4qOZlAHAXBiKidamhAwYW4zXrdGv+27xnb884gsdl7BMLwjN/yQ5qzfmVx9c4owRG4DOhVn6cF8te8c8sJCK7Vm5al9kOYa+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998933; c=relaxed/simple;
	bh=CMPSk5mRkCdtbGnML4bam7URPGZ7ac2FrMUz1ttH53I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcgzJxwadpZ6g32ZFu9rpzUTdZGk9FtM8ra8LdziO+NzlHCjHddzGQLPnfpPL+ew/X4q7C55YlP2ytqjMfy9Tw40/2iLAqhsOdMotF8rrTZ05Kd6km9PyGkbBpK0h8mJhsqATqBkROM/d+3MINTLQSU8YDmykRtsYwzZFhOmhyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1RYVylI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51288b2b549so514512e87.2
        for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 04:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707998930; x=1708603730; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CMPSk5mRkCdtbGnML4bam7URPGZ7ac2FrMUz1ttH53I=;
        b=N1RYVylIMSUl1U/MmDlLivwydHncPpdDsZYjU9QkSuJTht50zeZN1guEbVhKLFiNsU
         kxPZw0A/J+f9doGAqpi6tqaXTpU5qTA7zZg1LQhl4Hk1Ziomw1uLAehAubLry36HupOK
         a2ubb5oxF7+oYTmHMNraRoKTxU/5DsAyADUHq00qTUn6LGyR3nQ6y8O1J61QIhQtQTS5
         PHBbtE1DEPymsKTRGWm9eaIbRf0csQQBJqAzLRTnOHsJtSzgbSQeQGLHV4hwmc60nTeH
         d+G23P25e2D6Gr98DFRopYlEVdK9zKyAKQh6zTOvSEej/HjL3PpUeRFWaVCzrtNLfIoW
         /lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998930; x=1708603730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMPSk5mRkCdtbGnML4bam7URPGZ7ac2FrMUz1ttH53I=;
        b=eNauCutgiRPCPnTax2oSM76Ipbjc2Un9R2UigPVKFnABaewlCuPGk+U8qTX/e7Vyg+
         Ia9kPJq1xyEWu2zeSdf685Tioqr/Cg3GFng6gq3kvsz7k7WdqADTZghLbfEuZZacnN63
         0OwfXPdkV91cFIYvtSPD5wXj+MXkW/CszteVfDHDZlb1JN81jsKAiSExIZn8IW8rl+33
         VmeCbc0P/dBiSJ2BDYgevd0p+kZeW9lH+FAaLcZVSuzxt9iB5uTWbklim3/6C+acAay1
         ibDrS0D/UsepuBaSYoE8nAx8nmmi8GkBmxbroao4bj6dLi7Xnlll3nLvstcMl6FBcIjN
         kHTA==
X-Forwarded-Encrypted: i=1; AJvYcCXfbbkfCpJIzDSjWYIAId66hzD03rm8ilKL3BOqVPVvedITplAzv5vzp7Bdy5cwof0BYOgXNxIHRw25tnNiKbMJRQLXLgzFnJcm
X-Gm-Message-State: AOJu0YxaoUzLIij2dPslLI4TLOmsSQ6TiwsxQJZozxBkduPOjPZDP3uu
	lSY2pwdzfj/BauDmfogolKx57qa4UpQjG7EbxLFRTGOmY3zlSXpwPeaC6b0oALM=
X-Google-Smtp-Source: AGHT+IEk8U8CzLPp2+OgEkY6TQx1yyJAi+cZTYkgA0XB02c4f/pVDHTN6skxieBxdeZZPbKcDe7kKA==
X-Received: by 2002:a05:6512:3685:b0:511:8cd7:e17a with SMTP id d5-20020a056512368500b005118cd7e17amr1067467lfs.36.1707998929916;
        Thu, 15 Feb 2024 04:08:49 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b00411d0b58056sm1879272wmq.5.2024.02.15.04.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:08:49 -0800 (PST)
Date: Thu, 15 Feb 2024 12:08:47 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 06/10] backlight/pwm-backlight: Remove struct
 backlight_ops.check_fb
Message-ID: <20240215120847.GJ9758@aspen.lan>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-7-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240212162645.5661-7-tzimmermann@suse.de>

On Mon, Feb 12, 2024 at 05:16:39PM +0100, Thomas Zimmermann wrote:
> The internal check_fb callback from struct pwm_bl_data is never
> implemented. thus the driver's implementation of check_fb always
> returns true, which is the backlight core's default if no
> implementation has been set. So remove the code from the driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>

Yay! Cleaning up platform bus legacy at the same time ;-).

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

