Return-Path: <linux-pwm+bounces-3625-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2094899C179
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9EB71F20FE6
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BF9149013;
	Mon, 14 Oct 2024 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o28VWOZg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27C148857
	for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891310; cv=none; b=eyDBtnRUxmh8B0PaQOL1I/NtJsjKb5yO0X9gcsChbl1KJrO/nnXJxKoxG4xOElK7k5QPp9GkFePogdjWzXBu1vywb9bIhZnvDX0fvQLIWeT0kPXAV4S7M9Y6X3ahGteNEJYhYhV+Agcs/jiXU3VYXszVDgOLdKJvwqj5InvUWaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891310; c=relaxed/simple;
	bh=NEIbyKWfSfDfYub7dOi2+DthG1dy6lDUSX8rgR7BuE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL7LWmnKpsER1Gl5mGSDTvzSrLvfF9mTKVpMcYORI474YYM9v+VhTUiHSpSqYmQEJ/XMwQdI831O06FQT0BpBfi7Qya0UCjKcVxARE5DqE6IOg62n9b8Z7//btQF3mStmMHzp5aQk5af6Xbf61iDiejQNiI6bR97U0yU4VZ0Iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o28VWOZg; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so904425e87.1
        for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728891307; x=1729496107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXd9IRsJ/Q2GAEkeQwvXUDlljQikHHqovvpnz4Mnaes=;
        b=o28VWOZgDxC2YkO7SeBGhYEmy06T1djyswuxcia2ZYFIw82gwyfbyjAq6sm3ypoX+W
         d6SGya+dTqshAJViGaI/Qm+hXai3tM0NIkhgBLLDGvFXxx5GpoCSBNMdVMWWG8QLyDtn
         w7/EnEfH5zxqUn7EoIQ95qlPAmU3cjUyWRezPE6PvEukTYSR6XsCURWvMJPetX+apjHj
         tHLeXcwaCY669ioyzjMYGTW6cI0dIn/GzJwENbm+EZDg8CKojtS/B06HqIgO1AhCqThz
         ttAsdtu4gsbuLyCLybapI0mZamtn435Sb78kdCqGptC7VKJHAzSOvpV8zkXxqlHVzuDq
         El3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891307; x=1729496107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXd9IRsJ/Q2GAEkeQwvXUDlljQikHHqovvpnz4Mnaes=;
        b=U1rtEgJ927MhkIUtIR+YAgXif+v6ODHDBRVQVkiYrq52lCbN+W6N1wzbCwa0NseXEn
         3xw4f4I9Bjy6acepR0InAw1aG55wdoOpghE38UVukkdVFKWWopU12sdSYj4Ivd1czopU
         hSrznqxqyuqGUbwggg7wON7jxJ2v6TCJ4I4L4nf94as3Y6Jqwfm32xoPPenMpzrgXnWM
         pRlyupLoQ8LwA1BFAQuUReLxwFkUGZWifsN30mvS85rGmcPLjKholPKaz16RVwkyLGuQ
         LyiNeCwuvZu/zUSIWGkBwe+u/+gqVeJ2yiqr8NbD7zZI0wnJAEyDEiEtElzh2Vi2hEBs
         v3vg==
X-Forwarded-Encrypted: i=1; AJvYcCXpZKp/JzmZNvyTgwksaaXozqwcig89ICE2PkArfa2NJ4MN+LEc/D8HWuX+pVPXPf5192m26Bmw6hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzuC63TY2b+8VF9T8k4r8PgB06UdukbvkZDB2CBMU8Y2eZWiOt
	4MZrneXA8WJl5WD3QnlFQigdyBhCjxjlub/16pxRQzysVn4xv0Xelq/N5oo1bzY=
X-Google-Smtp-Source: AGHT+IFG5mAcJza7yiles85LfH/G0lB/xgU5IoFW9zjQX8bagRJinxpczK+JtOryP0YxXrBGl1BZ1Q==
X-Received: by 2002:a05:6512:3c95:b0:539:d0c4:5b2c with SMTP id 2adb3069b0e04-539da595273mr4520019e87.51.1728891306540;
        Mon, 14 Oct 2024 00:35:06 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539e48c1807sm953064e87.237.2024.10.14.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:35:05 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:35:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: u.kleine-koenig@baylibre.com, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Mehdi Djait <mehdi.djait@bootlin.com>, linux-kernel-mentees@lists.linuxfoundation.org, 
	skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10 0/2] Add driver for Sharp Memory LCD
Message-ID: <hfpq35cxext6vd7shppa4ovtszywzqkc5gqo3t7p77uldasxts@gyfrypofijmd>
References: <20241008030341.329241-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008030341.329241-1-lanzano.alex@gmail.com>

On Mon, Oct 07, 2024 at 11:03:09PM -0400, Alex Lanzano wrote:
> This patch series add support for the monochrome Sharp Memory LCD
> panels. This series is based off of the work done by Mehdi Djait.
> 
> References:
> https://lore.kernel.org/dri-devel/71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com/
> https://www.sharpsde.com/fileadmin/products/Displays/2016_SDE_App_Note_for_Memory_LCD_programming_V1.3.pdf
> 
> Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> ---
> Changes in v10:
> - Address comments from from Uwe
>     - Replaced -EINVAL with PTR_ERR
>     - Error check pwm_apply_might_sleep function
>     - Remove redundant error message

Let's wait for an Ack from Uwe's side. If there are no further issues,
the series seems to be ready.

-- 
With best wishes
Dmitry

