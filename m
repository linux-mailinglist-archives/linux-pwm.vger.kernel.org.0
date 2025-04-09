Return-Path: <linux-pwm+bounces-5398-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9387BA82300
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 13:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A35417F60A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A925025C71D;
	Wed,  9 Apr 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAYEU+Aq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49A25D914
	for <linux-pwm@vger.kernel.org>; Wed,  9 Apr 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744196407; cv=none; b=Td43vfCnW+9oOs35PiZFhREAu8QwsIlt/RsfKSYwmwZ7RkyCDWeYQ4HIHLZ1Ku18IQaCRNi/Hid59voi5V7QDdc8vacgFnys4+xydks3iTD503ZlyMO/qgETW6yQ8uaP7ujKbx6J/g8be0UmAgW5/DjgAhtEgXh3qfM/Hn1feaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744196407; c=relaxed/simple;
	bh=NgyN75PSDRFV18Vxt85zqi244DLcZTiGy+goFl/Rx7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A3vlDcm1+JCeSf0cVvAsQkiYQxcCEmPEIoY3ACk7tVLY6HZD+vtrMTRPyXFz7jwWW8evr28lPFkVufCsOeq2BQl1GqOTjgWMWTGaU1Fbg4ustsX+zuBJapn+xwe61uj3+6QcFjZbi6IyPG9jVIC0U+04Erw0c8Zfk/02+3N0B3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAYEU+Aq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so62086375e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 09 Apr 2025 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744196404; x=1744801204; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhNAMqpDYa9pW92R5WU+eJpzgVnuunFKFUqQDpASJz4=;
        b=JAYEU+AqE/QKbu0kTuGCdP5DUPk4t3VivRvTzgBs8hIjH4rDrsetxSAAN8BV6k3+5l
         1tHULOU9wfPl5x949gF+8IMIv2fj0KQRAf7j2XC5c+MtKjPENB4oNhfIQEcc8uW6U+yz
         GSfXKHCLbvHMo+9b5tAOd8yI6g3pIijugJ1yDNA1VjYMMXdYLo6PlVhSyZMAuBpYDgWf
         ctsnUwZ15oM1+ML1pRvjTrRFgLjLDoEXwtvqlJY5PltS1HRNcmy49+IUbljyApSSoLSF
         oJGm2U2KvJnkGAbJv3EEHn6Jtw0ZqKepEXOfCL7eeR/rnDlrH/Z/Y9d1xqlFi5MYOiWu
         9Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744196404; x=1744801204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhNAMqpDYa9pW92R5WU+eJpzgVnuunFKFUqQDpASJz4=;
        b=qQHmjzPeJjo5/zyJl2ygFS8GaQp9to12CYW2dyfFi6Gspb/+tI8vBb6SSZsLm3TNQo
         dTmALEkFRctxGBixwwwBCYvszvaFHx8wGqPrh2Ermqo63n1aq00Ucff6pdHRlBepE0Td
         3rcsjz0oCtHam7XjDosV4UWIt2eZu6GQUqir05P0WtgoIaggNDj7zIPpZwQBtlPbxso2
         6zGOIX5geHCdvstqcmbkfKoF3NsF9c3n02m3lH3Bbo3+29dQ73srIDU1p16J85bbuBMf
         dXsCkCOZuJDxZwpVIbcCiPLWrzgNdNAVNnEVtt+8Fk43wja+oaNYHeMs3I802g2XWg7j
         /UoQ==
X-Gm-Message-State: AOJu0YyfCl1ik+GlUXAzOQTin9XCYdwPe42IdwklPympZBnTEZvCylls
	WBjnRNYHsN2AEEOSQlxXtdkTN+Qd7tzXtqHbN010GywCvWGNJV5Sp2Gr8Dd9djNInEtEHAJ61JL
	k
X-Gm-Gg: ASbGncucP0cJkeYuBOSJv8vjRZaIeKJXZTrXen3EBgVfx7aAYUD/QhnxmpWW4B5uFew
	h3zV0kGCU0PORoEm/ddEpBsEpLmW70NLSj/74C/pJh3jwhYv5zfDo2IGTr7RHcNXUJOnwRPOAgQ
	wTT9cpZW/mY6+OY2g9LXHoj0BX7q1+ai91KIhBhohr7KSNkF7KNOYZqV5BFp9o3eTOWZ9MwSXRt
	yW9IQzjhIoHSdAeQx2RO1YR59XL0Nf/TQof+deOP4u/0C96+vYBv6znPk9U8WlsENC7rJPuqev3
	UJ/LF4M+snUWSkzusW14/Yu+zTUlZzJ3vZb0QtrQSt9vGQ==
X-Google-Smtp-Source: AGHT+IGNdByUELqGs5d3FWqjVnG+yUHiJnioIU3SVDJr9nlQKlHN4kdOfJqARYWvgcuKg3u6PJIMcQ==
X-Received: by 2002:a05:6000:2c2:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-39d87aa5654mr2130031f8f.2.1744196404047;
        Wed, 09 Apr 2025 04:00:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43f233c7a68sm12332865e9.19.2025.04.09.04.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 04:00:03 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:59:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: linux-pwm@vger.kernel.org
Subject: [bug report] pwm: Add Loongson PWM controller support
Message-ID: <44f3c764-8b65-49a9-b3ad-797e9fbb96f5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Binbin Zhou,

Commit 322fc380cea1 ("pwm: Add Loongson PWM controller support") from
Mar 31, 2025 (linux-next), leads to the following Smatch static
checker warning:

drivers/pwm/pwm-loongson.c:126 pwm_loongson_config() warn: impossible condition '(duty > (~0)) => (0-u32max > u32max)'
drivers/pwm/pwm-loongson.c:131 pwm_loongson_config() warn: impossible condition '(period > (~0)) => (0-u32max > u32max)'

drivers/pwm/pwm-loongson.c
    118 static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
    119                                u64 duty_ns, u64 period_ns)
    120 {
    121         u32 duty, period;
                ^^^^^^^^^^^^^^^^^

    122         struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
    123 
    124         /* duty = duty_ns * ddata->clk_rate / NSEC_PER_SEC */
    125         duty = mul_u64_u64_div_u64(duty_ns, ddata->clk_rate, NSEC_PER_SEC);
--> 126         if (duty > U32_MAX)
    127                 duty = U32_MAX;
                ^^^^^^^^^^^^^^^^^^^^^^

    128 
    129         /* period = period_ns * ddata->clk_rate / NSEC_PER_SEC */
    130         period = mul_u64_u64_div_u64(period_ns, ddata->clk_rate, NSEC_PER_SEC);
    131         if (period > U32_MAX)
    132                 period = U32_MAX;

These limits are unnecessary and potentially confusing.

    133 
    134         pwm_loongson_writel(ddata, duty, LOONGSON_PWM_REG_DUTY);
    135         pwm_loongson_writel(ddata, period, LOONGSON_PWM_REG_PERIOD);
    136 
    137         return 0;
    138 }

regards,
dan carpenter

