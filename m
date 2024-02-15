Return-Path: <linux-pwm+bounces-1518-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA72A85626E
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EDE2872DF
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 12:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D3712AAD6;
	Thu, 15 Feb 2024 12:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsXwhnjD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836712B175
	for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998560; cv=none; b=U6fb7nY36JBgJ7MGwRinYJoo7mjeMr2cbYQulkvJahno/NHmEMvxpoIvjKKrzVZzeIbNwEIlUQXf6g+Hio7/OcxSqhj3CiMPDDr3Yxyq1YThFqqszxBJs44Pk4aTozePy8BkYl1I7k8DkTh43WrNPCRBPO+UQCLQ7STa0xnoW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998560; c=relaxed/simple;
	bh=vbgRA2GMlce397fPZXf/sJUC3uP4O/JDU4BLWHn2As8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om4McCNfCPL4uZL2Vjr/vmfv9Eyd/XaUE9LYXdqWdDLqKQa2+qzfZ0x5M6ssTUiGqk0scAnFTz44QVqXYcj/bED4hiaYMYeAzuXwqtvEA96y3JsL5wGlV+ijZmpxckVSdgyjwuz1A8dUvGRo4PJFcGTO6ALvYI6CRuB+/B9KtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OsXwhnjD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33cddf4b4b5so564118f8f.0
        for <linux-pwm@vger.kernel.org>; Thu, 15 Feb 2024 04:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707998557; x=1708603357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbgRA2GMlce397fPZXf/sJUC3uP4O/JDU4BLWHn2As8=;
        b=OsXwhnjDPFNVM5GLiZ0J0gJL5R+PQeoy7maGkeplncYqGcEqXpR0WYYO6wzGFQPvGE
         CSBv5XrWnYh4va0cWj+Rw28nlEUU8bohKN7lurdLy0i4Fpc4vkGjSM9DPd2ZvIiM4kSY
         zB+Ja5yP0M1QkDqHIcTkPh3GPbMyevli6gfyjtNQbRQ5fKjRCMTPyZMfBOH3XhuRVlCN
         akltg8uPN/4zw54CZ97TnEbL1xU2fpfSqHSH1lqPWlqjifRxdUIyKtxMm+LnQD4s1f88
         7+ajLJHMZnE2ByIbvcdxP9WsGlVUuFZ3zrHe59t7gPjABpNUv/bTOleJWL8OfqqBZDFE
         MBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707998557; x=1708603357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbgRA2GMlce397fPZXf/sJUC3uP4O/JDU4BLWHn2As8=;
        b=DMlucSn7C7L3KEkL4gVN4udwqIlF0r7IzbrhMQcM2OaCiKWyidZtNpNlw3csURcTaN
         4SMj3o+9EsRd8IyleCEL5E+YUEG5qYV90jyqLUVkVnQC0LTSaUevZFB4p0u9RDw0A8PI
         I9A+jPphrrsJGWWjjHwMeT3D8DcJSjBBerJLlLre9pl41R3z70eKRMc/VXVX2yI7EZry
         Iq3hrOrGAaTrP+qnMfLyd9fxj1wSsxRUczC6WWqCpw8Ket2iqIoKBnvNUUYZ/SUjwBE7
         kpnfrGQHxdi9G5ZOSjH2VH/7vvYvrIEJVJiRophZBtIvbApZ99SQkrvRcRmjiHvjcSGB
         F+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXexKjvzsxMVKU0TjKyhHLwiRxZqb1uW2++S9dg4wTdwtKqunBvxO4jRPCjKYnUJfsAojOQis7ULBH14WcxUe4sG+VW9FLgMTsh
X-Gm-Message-State: AOJu0YwV+FfC5evN5m9UQAbU0IFf3WvLm+NPSytAxCD4igTlsQ3HM8Uz
	tJLcbLWku9DYrdDiTYMwZb9shvViw8512Wi06VsDuAxWj0zHdO/WO6pPrCTVj/g=
X-Google-Smtp-Source: AGHT+IHkovjjm6uiGh8NEiN+5Igji2gmONxw1ozHtZ/fWfNAab/0bhMXeBul3IX7/uedCw8IfPnK6w==
X-Received: by 2002:adf:cf10:0:b0:33b:2884:edf2 with SMTP id o16-20020adfcf10000000b0033b2884edf2mr1196357wrj.56.1707998556956;
        Thu, 15 Feb 2024 04:02:36 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bo2-20020a056000068200b0033cdbebfda7sm1407012wrb.14.2024.02.15.04.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:02:36 -0800 (PST)
Date: Thu, 15 Feb 2024 12:02:34 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/10] backlight: Match backlight device against struct
 fb_info.bl_dev
Message-ID: <20240215120234.GG9758@aspen.lan>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212162645.5661-2-tzimmermann@suse.de>

On Mon, Feb 12, 2024 at 05:16:34PM +0100, Thomas Zimmermann wrote:
> Framebuffer drivers for devices with dedicated backlight are supposed
> to set struct fb_info.bl_dev to the backlight's respective device. Use
> the value to match backlight and framebuffer in the backlight core code.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

