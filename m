Return-Path: <linux-pwm+bounces-6574-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480B6AED3D9
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 07:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D979188CB26
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691691EA91;
	Mon, 30 Jun 2025 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No7wJ/7s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0150C20E6;
	Mon, 30 Jun 2025 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261452; cv=none; b=hx8UuzR4kU2byjdrTOIGRezAuxMUk0W3ptMzt0yznYWouVF3SZHFmTeY+xA1WbEyGi7YkhIxHj4w6DDtjTbyB4rR7n4Z5B6VH+Fjbd9DR9jZDGDQAaT8JbfIyaOHwvBJXOPhdMgv5DL+P4ubrx+2CRvPjGAUhIfvTXfAZ/14ALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261452; c=relaxed/simple;
	bh=guuqdFCuq72EhMQ656ZcTL0O2E7hyfymeCKX+rDBKNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSQdW2AwYfv5WnVLi73yqwljRRHhrn/uvb4Tzd0Ib9rcSbvtX/BaicjWgbwPlafVSSciGqvwMDt8/MDvEr9dk4GiCjrx/ml1L/PmFj7XBrmFz+KK7rMbkGJ54WmMx/YTh9rGmnVuXnVBQUnOF2p4IHIcLuMqHnarPTcSJoDPODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No7wJ/7s; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73c17c770a7so2255858b3a.2;
        Sun, 29 Jun 2025 22:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751261450; x=1751866250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YkbfJVH8Et0sYABpBPIhVucDte8hR68TivaYURJ1BDU=;
        b=No7wJ/7s0UZupBKYcm7H75z6/EEprrSlPTgm9V0sSmn43GjcJeCUyUcE9jKS0CKU8Q
         s4WBX5k+ZU336wrTjebFGeZT0pMstpdOBP/XLn80DcQ6pVv+17C/us2ZrhwyXIER0OXC
         agUAKB/BSZFj5/0rCRiU2OhReK3P7TvygPKhxBpSFtnIgnJw6fn2vCfR+Oeew3PI8urj
         zwi67MQ/vciulERZ8o/TKqNPqgnUdwPY3x7Ho5Euq/ukn+CVHBEzifo+jNdjSidQpT3x
         y2lsXSUjBHedD8p0db6TCRMpMJgfNbikNBmXFHptqQRzBM6DT3wqnDmIU3QQRpk6rU+y
         mD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751261450; x=1751866250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkbfJVH8Et0sYABpBPIhVucDte8hR68TivaYURJ1BDU=;
        b=hMNoHsE7HubNXDck70P3we+9K1SsbZtBlTBh1kWdkBvRZAxDYVyzXKKOsdRB7Fpxpl
         nVgO4prGK8A3aTZZy3StNFfTbzfmADW8787fttGjpGyf4gTrjolLZ/doVhWVEO4oj0z2
         C6JWHmWPJ51IDIE2L3FNzaQlBuue7hAjqwQ2+lJ/F76/3NNNc6fAbJVi190qTwCs1+Gk
         LQrE4thW5M4hB2cwyqfM3OKUs6pHR+qQCq36IBD9spKmC5Lq3CWNfZ+ph59U/+70b2Ty
         0oABSxrcoN/hccw+Us+GGPHd7E4Y30D2uQGRp5gPtgoeNOrQQTPW8+iOEcgt5FUz1/WB
         arTw==
X-Forwarded-Encrypted: i=1; AJvYcCWZXJhPCmIIOwHcgZU/X60YlnRc21lTLynbyiQS+GVUuHmkwahuQ3viOOSMISJNqBqGV/HLDaqzdVmXig==@vger.kernel.org, AJvYcCXQN5uaUiSv3xl3nFumfDO+tPZTfOXV5Fyec/mCVSCHCTKk8Gw6SzNH1u6/uoHWv4X8Me+lrNWEXZNp@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJc18XaueNT3j6j2q7nWuxGNxjuX9a0GfWyBGzzhoJ3S74iK7
	wNqvgBZTyebEqbXCsOZbPnuRaX/ZKBODzOW2yQjqRmI4QDuEX0ysDIYB/FcZcA==
X-Gm-Gg: ASbGnctebg68GE5g5j4uMTQ+SBb674ZMSImrjTDbLafC+M66N+jrTrgLjirbpmMmOus
	xuE0pM5RNMRf6FP6WZlqxo1OszrH0EGgPwEsZWabjoNdtcrO+re1eum+uTKUjGmMR07MuyDaEJw
	1FzmvgzclZ+agtp2Jeuv/mWH8Jzv7G6CvKF5MnznQWQ5WE5SSb3BiaE/OxEXAdrDw4Cv5k6MyUo
	9BhnQOX3n8Ks8Hx19jOAzMgJIxgw4RRKxzAbo2zKJGbH5iFaNLPrwckZYatCJmFBmGKQNtE9JqT
	CLDXZdQXBhqyhgEp0ta84sGDzQXBJ52IFJV9rvmLyxssJvF67vTcE7sec7gxlA==
X-Google-Smtp-Source: AGHT+IFU0WLw43HCU+hfz+CAohz0fR5iGVMff7h8lDipW3wVZQUGqRJpjpaeaTnfB8G/qIs5x7W8kg==
X-Received: by 2002:a05:6a20:748f:b0:220:7e77:f4f7 with SMTP id adf61e73a8af0-220a15902e5mr19259603637.25.1751261450151;
        Sun, 29 Jun 2025 22:30:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c92b:c666:1f8:990e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e3022e55sm6342954a12.24.2025.06.29.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 22:30:49 -0700 (PDT)
Date: Sun, 29 Jun 2025 22:30:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Input: max8997_haptic - Optimize PWM configuration
Message-ID: <aaq3c6aljqt63ilx3v5555ususxcrg4kgnezicsesdbmio6zqh@2xrok7qlbjrp>
References: <20250623112742.1372312-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623112742.1372312-2-u.kleine-koenig@baylibre.com>

Hi Uwe,

On Mon, Jun 23, 2025 at 01:27:42PM +0200, Uwe Kleine-König wrote:
> Both pwm_config() and pwm_enable() are wrappers around
> pwm_apply_might_sleep(). Instead of calling this function twice only
> call it once without an intermediate step.
> 
> max8997_haptic_enable() is the only user of
> max8997_haptic_set_duty_cycle(), so it's known in the latter that the
> PWM should be enabled.

Right, but the question is: is it OK for the PWM to be enabled before we
enable the regulator/power up the motor?

I'm afraid we need to use 2 distinct steps...

Thanks.

-- 
Dmitry

