Return-Path: <linux-pwm+bounces-154-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4151A7F4F27
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 19:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640981C20AE4
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 18:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5814F5EB;
	Wed, 22 Nov 2023 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lpb9202u"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7384F110
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 10:18:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332c0c32d19so3130280f8f.3
        for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700677106; x=1701281906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHYnD0Po/dYKPMMF8EH1EryMVyB3OKYjMgkkFLJ9EPQ=;
        b=lpb9202uA5jT7c7XbKb63Na4MwxnZ3t8dXHNhEadlEW+YIclMyBLm2viUOG2hMhDGM
         lgWUET544pvlT0iBrSiOlmSU6PfmDhFV2QyE/BRDucLmypA17+4gW3pmEmOJQMFdQLv5
         UOOJSlZudx03F6AbQziqEi1tuCVPIgmSBzGI98v8jwvIO+izFbvwx663YjQBZRQtjX8h
         IByTDT+7u9RQoKmiTemxznwCiUGrtIIDo3LMR/YjnLSZw/K1K0szNTPk63v4QUDc27kC
         urg4Py+oGNCJz1Snpwg1jKyZPuRU2lxkL89dY4h6ctZ8iIWndB9Xv8ld2a89rQ0ldJP5
         GXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677106; x=1701281906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHYnD0Po/dYKPMMF8EH1EryMVyB3OKYjMgkkFLJ9EPQ=;
        b=Y8ByFpiPF/0XhK1Is7vzinvL+yOwXJs8Q2YL51RTZ6GvggKnTbJ1oLtQEbF+vYg77n
         EJzKwQs7XumZknPSNnWZWY8AikC1KMxiDDGnYnYvJuHePcK/NdawJj+2ofPeB1gnjAZC
         P/BJHJikMOPE7FSK5mrp4Pp4aIuLbtfs51uyUsicc9USjjvFFRDEcU2B7Ajgd+RpQdm3
         /Gu5T1IalsZ5pfSWyjvnpZeFCGtpUTXz4kAxyFs/w3OEjZvBOcj5yHhSNOVFPTXZIlqw
         Wcd2hAZhdh/rpJAcbb4NcMIDwWqKGjUG9qGOsYPSpWCZ6//m6CCDoDVjqjnHeDp3uDQS
         sxqQ==
X-Gm-Message-State: AOJu0YwvcO0w1jrW200F+GgcaknQOkFOUZ69vjE21BdJCPcH0eFZroJ7
	J3KPmgCG/L5V0S6jBj7TzZwt5Q==
X-Google-Smtp-Source: AGHT+IGPNGAtOAyMyTkybhU4HYxQ9iIarZYNk96gS0e95g7JSaZVC1yWxBkAafqoah00LLLxbio90w==
X-Received: by 2002:a5d:6c69:0:b0:332:d33e:6584 with SMTP id r9-20020a5d6c69000000b00332d33e6584mr1939868wrz.45.1700677105921;
        Wed, 22 Nov 2023 10:18:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600000c800b00331698cb263sm7672wrx.103.2023.11.22.10.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 10:18:25 -0800 (PST)
Message-ID: <26d9dcdf-d015-493e-b2b0-eeb538e7caf0@linaro.org>
Date: Wed, 22 Nov 2023 19:18:23 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for
 LPG PPG
Content-Language: en-US
To: Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
 lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org,
 andersson@kernel.org
Cc: luca.weiss@fairphone.com, konrad.dybcio@linaro.org,
 u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com,
 quic_gurus@quicinc.com, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20231020182218.22217-1-quic_amelende@quicinc.com>
 <20231020182218.22217-3-quic_amelende@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231020182218.22217-3-quic_amelende@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2023 20:22, Anjelique Melendez wrote:
> Update leds-qcom-lpg binding to support LPG PPG.
> 
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/leds/leds-qcom-lpg.yaml          | 89 ++++++++++++++++++-

This causes new warnings, for which fixes were not included here, not
linked in cover letter, not linked in changelog.

Please test the patches before sending and be sure no new warnings are
introduced. I should not test it, it's your job.

Best regards,
Krzysztof


