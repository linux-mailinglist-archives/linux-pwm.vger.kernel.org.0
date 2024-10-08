Return-Path: <linux-pwm+bounces-3538-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DA9994AEF
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7899BB25D83
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD3D1DE4FA;
	Tue,  8 Oct 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oKjB8at5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61EA1779B1
	for <linux-pwm@vger.kernel.org>; Tue,  8 Oct 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391084; cv=none; b=pehVp3q824DVVNiHubQvnBqwFFaoylqJEOe2ir0+upQtc+ITkoeJ2WRLZl+9HpcRJOB447AadPkpCiTyFS5NQmk9dJJl+XDmYWMRAkKyi+qdBR89r3WgXw3vWML3qixNZ+aAQOG0lNAljYsVi7S883Y+SHGWHEaxBvZxnWz1z7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391084; c=relaxed/simple;
	bh=1L+JpoFCpEvtlQx6jbzP7YtJHJrlbA6UEXXyge/5nuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q4R/ffh4yYXHg6PT0Ij/cBEvdh4oZtQ7bFS0mVtepD9QtFZgqDbpcaJOut+GRcI7ebUjXaf1/eqgf5xJslVqbe56P/nv4fV3omJ0TYwJRsmK1xt3CEpnaJA88FAKT568xZX+HAPimK/kfa0nYCRNxkxPY0CIJ/0r2YngVHOn0Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oKjB8at5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cd8972738so3851472f8f.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Oct 2024 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728391078; x=1728995878; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=by4sWSBDpCIFjcZGzg4X08UIZKTUMpJ+pa0NCXVeqdU=;
        b=oKjB8at5p1Ifzf8ApUugOYHNslEHFzcIvxM61VLP8GsIrCSLrbA1zqmf5yGIPpZEL4
         SOwovsxCt0XDwpFy1ZWNvLmz+PTNG+gqiK/RHHgkN/uavO4TyvQnOzkXuMz25bUPa/lT
         a8GfVUrtpcpDLkhWHS76Ae91VWEP5DB5gCueSU2cYUsN1s3guocMbMnixAxYWuJWh4Eu
         X8L47W4Xl7/MFkiqq9qmsEoHnTtp801XKFsEI7lqfYhzPwZ2Tj/4t01xioiKQFGNg2i8
         2yHogmM/nd/446Q7fnXBGHSAQr3kWJxOZexI2wPHj0gbU39qA3tEJ+6JpvuMOD45IWRD
         eUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728391078; x=1728995878;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=by4sWSBDpCIFjcZGzg4X08UIZKTUMpJ+pa0NCXVeqdU=;
        b=F7vKpuLFb40bDH0mRx4N8Mlyr+Ge0u5fzc9pwDTvV1FzKPiP6xcbP1gkkoY6r0PeRU
         c3HCGU93Ek0vRBQqAZ/VLW475iXV0VcPtvwN4Wb+1hqEzgrXmd/IKegJp6+MErS9ZXSQ
         B9ySf2eFDKDxUh8cHrW3x+dgyP1zFo/cXYGaVeIKSbKlayhaojQwnX/BUWb2FKLCRxpy
         7Hmdd1QTn1lCQOAz7ZKV/0Y71+qJDyeGkPw98qBlW23IwKngJGzDcoIXQ9dS/bWNo6qj
         tLs+1nVe44zc5Wgrt8TBfdErA4KkZpm8ywSWkZviY3G+35eDSx4xJ45VPLRd6yCXeVNY
         jhsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9sxbs+vtwePdL6FKx0pV1UAEPzV1k2Cg8n7bB7CY4IOhQmkjJfho8+iKYSj/esV7fApE5wMaQUVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4J57AgR+0Wm65wDvMThJGdntSAhQSF81bFWMm/pbbRgnnNWBH
	gMZ89rCaiUraWnv3EjVwXwfU7telB/+8gcv6yRDZ0863ijp5YlDSL4qz86cryB8=
X-Google-Smtp-Source: AGHT+IF7jLyp1F9r1R7paqLXL7lZm4mJSG2e31oTisk0Sxja0KjHZpxs+MoHEKQXr+fL0PGmbZlONQ==
X-Received: by 2002:a5d:5e0b:0:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-37d11311be4mr7478306f8f.26.1728391078001;
        Tue, 08 Oct 2024 05:37:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43050578facsm20299775e9.19.2024.10.08.05.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:37:57 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: neil.armstrong@linaro.org
Cc: George Stark <gnstark@salutedevices.com>,
  u.kleine-koenig@pengutronix.de,  khilman@baylibre.com,
  martin.blumenstingl@googlemail.com,  linux-pwm@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  kernel@salutedevices.com
Subject: Re: [PATCH 3/3] pwm: meson: Enable constant and polarity features
 for g12, axg, s4
In-Reply-To: <5c3a6fdb-e4f0-4a22-9a8d-84baee12769c@linaro.org> (neil
	armstrong's message of "Tue, 8 Oct 2024 09:31:09 +0200")
References: <20241007193203.1753326-1-gnstark@salutedevices.com>
	<20241007193203.1753326-4-gnstark@salutedevices.com>
	<5c3a6fdb-e4f0-4a22-9a8d-84baee12769c@linaro.org>
Date: Tue, 08 Oct 2024 14:37:56 +0200
Message-ID: <1ja5fesrbv.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 08 Oct 2024 at 09:31, neil.armstrong@linaro.org wrote:

> On 07/10/2024 21:32, George Stark wrote:
>> g12, axg and s4 SoC families support constant and polarity bits so enable
>> those features in corresponding chip data structs.
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index 6701738c55e3..c6f032bdfe78 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -571,26 +571,36 @@ static const struct meson_pwm_data pwm_gxbb_ao_data = {
>>   static const struct meson_pwm_data pwm_axg_ee_data = {
>>   	.parent_names = { "xtal", "fclk_div5", "fclk_div4", "fclk_div3" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_axg_ao_data = {
>>   	.parent_names = { "xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_g12a_ee_data = {
>>   	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
>>   	.parent_names = { "xtal", "g12a_ao_clk81", "fclk_div4", "fclk_div5" },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
>>   	.parent_names = { "xtal", "g12a_ao_clk81", NULL, NULL },
>>   	.channels_init = meson_pwm_init_channels_meson8b_legacy,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct meson_pwm_data pwm_meson8_v2_data = {

This needs to be splitted and adjusted as well then.
g12 and axg are covered by pwm_meson8_v2_data.

>> @@ -599,6 +609,8 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>>     static const struct meson_pwm_data pwm_s4_data = {
>>   	.channels_init = meson_pwm_init_channels_s4,
>> +	.has_constant = true,
>> +	.has_polarity = true,
>>   };
>>     static const struct of_device_id meson_pwm_matches[] = {
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

-- 
Jerome

