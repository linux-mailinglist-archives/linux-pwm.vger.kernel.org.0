Return-Path: <linux-pwm+bounces-2056-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B7A8AF5CF
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Apr 2024 19:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27E91C23CAD
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Apr 2024 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F413DDCC;
	Tue, 23 Apr 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D1/yBDrs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667613DBA7
	for <linux-pwm@vger.kernel.org>; Tue, 23 Apr 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894381; cv=none; b=KwaM/GomxOfaR00rJy7vfPMQtFq+MJuYFUQwsa5CtMw7Z2yZHv7xHjnN76uhHf/h3VZmbrePMLnBzgnrWakZCvbBKdSGIuO4QbvjoHzmg/nk+Tnl9538xfrUUL3Wpv4qkj1LvA4QG/UakWlxALEsTcZFzy+H8vJkSayzwWoMPv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894381; c=relaxed/simple;
	bh=1xND+7laK1/gHR/yIQlfzJQ0FdJnQbg+vOtHDtxU1AU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=NfncWnp7nYySkg0Bg5nfalez6uYpIKDD2PFLliprOOyBNyGPLpArWRMBXd2XBYCaxEqXcIk5kEe/IvWiH7rjrrIJZA6rT4HNfL9SA+8V6uCzdXWXp7fAZSanyGz+AFgFSWK8OfPUkLz5Es/PAYn/GMeGYiyj/R8F/Zn51D2mun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D1/yBDrs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-346b96f1483so50892f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 23 Apr 2024 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713894377; x=1714499177; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zGMw34tv1HuOcHijB9t3OKRrzUWV9Hg/9xS27N3bQHs=;
        b=D1/yBDrsKu/IB808NgWsxCP9x2qdawHtG/sEccKmNEfliAimsJITsVwGdwLJLVepjm
         tjM5s5l5LpTSwpOpF4SBRj9kb/cakZtjXEBTbQchfWETLNqN/HnQp41M8zj6xzhkMz77
         0p7cMRyZfcOjsFgFLvyGoeVk7Fd2SrdOrtNhngsTmSoquvm5/E85kaq2Caj0j7TIglGu
         ePCbvCBbPSmSCpXKlDd/Ao/9PLJoLlaoX9TSK3vuoR/rp7h9EgEIHUJetPurnD6wK0nN
         9W4KxpzzodcmKINEnYiSSPxklprqBkLECnrss+W1rTJfioECkzTykueCk0WIKA/wrtyu
         1ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713894377; x=1714499177;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGMw34tv1HuOcHijB9t3OKRrzUWV9Hg/9xS27N3bQHs=;
        b=PEFnfqOmsDYx/zIyf5z5sHw0HvfocpPVGEqIFlOcr9BbSu3xEjoR4BeK78FkZ9ZINz
         gHBspjuzaJjB8+YZTspM5/PqnYQydGh1eWm2uPgiGS3gvGvUmy2RBVyzMx4jRbfkFkvr
         klymDvxkjJrH0/nuiv6Ypz0ex05thjrsTyrRr/Exs7/rnviTQU9fOasvRuDVUQGl+Wdu
         epbphqu5Tzd0aK79vJ2Huio0+CrTlhU3DvGh8Dn0hfaNxNNUUHYc3cE0MTZMa1tA4OPn
         VS/ZPnDDr2BhKE6siTvSFeOR1CuQBXxj9pOyYGESzFm4OJnczDXzM+R8+xlRwvlW8CjE
         6d2w==
X-Forwarded-Encrypted: i=1; AJvYcCWdCis3SBIE4MRp7bixiMg+BNZHotH3g9my9KFeybf7I44jG8MKpmRoM8e43JuY/2MMdZGYHjj453ga0/ddnpWcvDEX3S2tSIUw
X-Gm-Message-State: AOJu0YwpXo1O5OSmqoHO21s5fVPYkbjGPd4dyTWsOjChZSg99DBSbPvM
	7c8aNF8EMeU67ddiIyN+gMH9RQGAaFP39fh6/b47kgx8lI5s1hgmvhE1ckxgrNQ=
X-Google-Smtp-Source: AGHT+IH80+mYiY8wLOolbQuNc5GEwyFsWGYaA4bWu8luwqVmUsFfilpQUnT2LT28gZIz55MBD8d4Vg==
X-Received: by 2002:a05:6000:18d1:b0:343:6c07:c816 with SMTP id w17-20020a05600018d100b003436c07c816mr110767wrq.16.1713894376770;
        Tue, 23 Apr 2024 10:46:16 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:aa38:830e:cbbf:591])
        by smtp.gmail.com with ESMTPSA id l18-20020a5d5612000000b0034a62e51429sm11993475wrv.112.2024.04.23.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:46:16 -0700 (PDT)
References: <20240423161006.2522351-1-gnstark@salutedevices.com>
 <20240423161006.2522351-2-gnstark@salutedevices.com>
 <20240423-wildcard-smoking-90b50f00da50@spud>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Conor Dooley <conor@kernel.org>
Cc: George Stark <gnstark@salutedevices.com>,
 u.kleine-koenig@pengutronix.de, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, thierry.reding@gmail.com,
 hkallweit1@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel@salutedevices.com, Dmitry Rokosov
 <ddrokosov@salutedevices.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 pwm
Date: Tue, 23 Apr 2024 19:44:35 +0200
In-reply-to: <20240423-wildcard-smoking-90b50f00da50@spud>
Message-ID: <1jr0ewezvc.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 23 Apr 2024 at 17:56, Conor Dooley <conor@kernel.org> wrote:

> [[PGP Signed Part:Undecided]]
> On Tue, Apr 23, 2024 at 07:10:05PM +0300, George Stark wrote:
>> The chip has 3 dual channel PWM modules AB, CD, EF.
>> 
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>
> a would sort before s.
>
> With the re-order,
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.
>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index 1d71d4f8f328..ef6daf1760ff 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -37,6 +37,7 @@ properties:
>>        - enum:
>>            - amlogic,meson8-pwm-v2
>>            - amlogic,meson-s4-pwm
>> +          - amlogic,meson-a1-pwm

AFAICT, the a1 interface is exactly as the s4 interface.
So a1 should list s4 as a fallback and the driver should match on the s4.

>>        - items:
>>            - enum:
>>                - amlogic,meson8b-pwm-v2
>> @@ -126,6 +127,7 @@ allOf:
>>            contains:
>>              enum:
>>                - amlogic,meson-s4-pwm
>> +              - amlogic,meson-a1-pwm
>>      then:
>>        properties:
>>          clocks:
>> -- 
>> 2.25.1
>> 
>
> [[End of PGP Signed Part]]


-- 
Jerome

