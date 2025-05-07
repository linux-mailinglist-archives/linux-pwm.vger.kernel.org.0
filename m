Return-Path: <linux-pwm+bounces-5842-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E99AAD955
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 10:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122B47BDC0E
	for <lists+linux-pwm@lfdr.de>; Wed,  7 May 2025 07:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB83221714;
	Wed,  7 May 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAsyMpah"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9D223DE9
	for <linux-pwm@vger.kernel.org>; Wed,  7 May 2025 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604531; cv=none; b=kiEBtiif0nuMrOggqToJQ5oNUYL09PA46eTM8JaqC77s/s0bz8GI0kbCmUj7qdvX9iipG+3RiPN4T2zTZU8gIaY6K6Sktin4VMXbm8plzCy4+c8ctYpQnvDlvmdXoJoN6ktCs+JzXm34arZv2pmcAoFuCo+QSEIOH4mllh8wlJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604531; c=relaxed/simple;
	bh=q6pNPs0UuN6WlRKaJkUjx2xsLLW66yNqWqj7oq0oEBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYqsDlCwt3ezqQvh4lhvG6+UZZy+5P7Yx2b0vBhj+kwgXNkcC0SNWfIo/QVzlqe638JPqMMJYEspZPRQVRjCt8G3svQxwJGsdyC/FJr7jg3K046oZ97Z6NXj5oOR+xe7lNSEntOpwK+SDXcVXggtOrWQOpbi0SYFXcP3IpyaPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAsyMpah; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39149bccb69so5126516f8f.2
        for <linux-pwm@vger.kernel.org>; Wed, 07 May 2025 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746604528; x=1747209328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBL3qIVf81e3PhkRqu3EdoePuATSbIziAx1f5bGu5+Q=;
        b=XAsyMpahI3Avjef5C/FsbxPfog4HQ/ERRThKWUgHnt+W2OYpbx//L5RhqESqyNdKz3
         aXG4Kt4Q+V0jPt9ILrMCvlBvkHgjwP4/hB229sSGatcJIZOsijzxZMtjRArqpHzab8ZA
         4A7j0Z9X/KBfvkmhRta1gzno5aymrIZzrSGuavC4288sBQMV+YaPxaWIkL395XGtjyAL
         gDPA+IydTOp9MlXzngQHRu0AtRf3sLA8pn0CUwoxKPZqBhANsSjFlTUYgY8Y11ZFACFD
         ZsYZ2M0jFNdHM5slxcWOHS2cOh55iLuT9cjvVA4sXa3NkMSrjKPTcAZkPx9v2VyS2aD/
         caPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746604528; x=1747209328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBL3qIVf81e3PhkRqu3EdoePuATSbIziAx1f5bGu5+Q=;
        b=qK044Z1ampgGcaYfHjpdbo2vonbIr0gB4ec/GPAfjO51FugVV0YevzWdkSMQ7QGrk7
         Mm23nYt6jHbn6osIMVGeXMjw/T/BHFhhMDyOy84V4Gwy2yusgEVmZ1jwnoeRgV9B1ggW
         sE3m6WVds6p3mXdTmHyPGMu+LGAB6RnQp+6SN2YMI9zzjcpcf9rNc3SZ64Tl7CYE3p7u
         jZwmird9nOGE1I5clbIdagE1Qd+3uItofzZIS5aU5vqPKcW8L7W+zxcD7zYHebpF7hqK
         w53F0A+ggywVbzHYmQCGImeDxQKPa0awhQlrYK4dT6Q3rpKQxmPzTJNevGSc3hZlv1n4
         eTfg==
X-Forwarded-Encrypted: i=1; AJvYcCUkhhM6BeCzpOL1jGtzYxE5Ymf48GeWx6xKLWqSvmzCurRqKlIZovQiJzNkv7juqtb0C07/9sgcEIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LTxQGqWPMzBFI4R1clNbgrx0weXGySnfvZfH7MKLe0rM9zLO
	qL1Uz6Dtpb7OhRmcsUdIrmNBYWVlBpQ2OjxohlsZ8iPkIY6vMdpqppgPnq5zzFk=
X-Gm-Gg: ASbGncugYm/PEnTpR0FAZR/OhaaeJUfmXIr8W3WPdmirGaWpPcRgz283Xn9VS+OQzj1
	y8RrG508exQU9iEyANB/OLsZxcCRX4LdWtrpsCgAsGUmqOhyqZbsOkkdn7DP4Uv6vnhjuDNE1sI
	oOvWiaVq8o3MaSQBJYHgRWVqKx5It0x997JBsw1jXhejBqzERuP9RMf5bdrj0DJFuilok8OTgWz
	evfr0SL5SZU30J+GN/QlPABQNvcWB7XrTfgEvzC/bgb+SMDZG0HUa4PSuw9UXmxXaujYZvCWZdU
	46PWvfDADlTe8aZXmmRuMF2onWtb0bbzGrYd9u6du0iyjcWV+DcDVQDOVKUxFTElrIxn+LdeM2/
	b16U=
X-Google-Smtp-Source: AGHT+IHSub+w3i180SBYtmH4xnfpAxz/7R8NINsxJdekQwKRKRmtdqdbqRAvzeMDt6WyEG1Omh+Khw==
X-Received: by 2002:a5d:47c7:0:b0:3a0:a3f3:5034 with SMTP id ffacd0b85a97d-3a0b49d26bemr2060932f8f.34.1746604527781;
        Wed, 07 May 2025 00:55:27 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0ad54f105sm4491875f8f.85.2025.05.07.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:55:27 -0700 (PDT)
Date: Wed, 7 May 2025 09:55:25 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, tglx@linutronix.de,
	ukleinek@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jic23@kernel.org, robh@kernel.org, catalin.marinas@arm.com,
	will@kernel.org, devicetree@vger.kernel.org, wbg@kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH v6 3/7] clocksource: stm32-lptimer: add support for
 stm32mp25
Message-ID: <aBsR7W15mPQiTjCc@mai.linaro.org>
References: <20250429125133.1574167-1-fabrice.gasnier@foss.st.com>
 <20250429125133.1574167-4-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429125133.1574167-4-fabrice.gasnier@foss.st.com>

On Tue, Apr 29, 2025 at 02:51:29PM +0200, Fabrice Gasnier wrote:
> On stm32mp25, DIER (former IER) must only be modified when the lptimer
> is enabled. On earlier SoCs, it must be only be modified when it is
> disabled. There's also a new DIEROK flag, to ensure register access
> has completed.
> Add a new "set_evt" routine to be used on stm32mp25, called depending
> on the version register, read by the MFD core (LPTIM_VERR).
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in V6:
> - Fixed warning reported by kernel test robot in
>   https://lore.kernel.org/oe-kbuild-all/202504261456.aCATBoYN-lkp@intel.com/
>   use FIELD_GET() macro
> Changes in V5:
> - Added a delay after timer enable, it needs two clock cycles.
> Changes in V4:
> - Daniel suggests to encapsulate IER write into a separate function
>   that manages the enabling/disabling of the LP timer. In addition,
>   DIEROK and ARROK flags checks have been added. So adopt a new routine
>   to set the event into ARR register and enable the interrupt.
> Changes in V2:
> - rely on fallback compatible as no specific .data is associated to the
>   driver. Use version data from MFD core.
> - Added interrupt enable register access update in (missed in V1)
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

