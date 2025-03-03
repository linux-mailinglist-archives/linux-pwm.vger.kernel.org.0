Return-Path: <linux-pwm+bounces-5073-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A9BA4E6A8
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 17:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A978A6D0B
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98F286292;
	Tue,  4 Mar 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tcEKZu3A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08928D04E
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103991; cv=pass; b=IXZOvK0weCd9k44QD2+gX41uykq0d4pwpNmpM08MvEpVd9TB9wqImhc5UoXhhpXvxL7fVXMP8JO6/X6A41dtypgMvIsCMBIvB4u/KAb4jNF/DRfN+87ZdAOMblqf2In63aM/jR/FGzy082wukX7Nl2E0RX8eqeWoSTabC/GzW9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103991; c=relaxed/simple;
	bh=uKlaO0VtSYqlCulEvoLtkmUhyB9oj5gsIjZc4WzZr5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlzkEluwYOslbjrYyPwLSIkzvknGu+HJp3Sn3q6O/aKaxtqtrA/9vIvHDBlbSG7/cGmjb8eFO++r2hHhKvWb4kxyQWRe7BXuFJAa5V+R2Of1MET6ielLWA5kssbOaaP4EkZZaEcnxXujJptb5co/muZ+Ds46p0BMJc16sYNMSws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tcEKZu3A; arc=none smtp.client-ip=209.85.218.47; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 3542640CEC89
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 18:59:48 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tcEKZu3A
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gMQ584wzG1ww
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 18:58:26 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 87DE442724; Tue,  4 Mar 2025 18:58:15 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tcEKZu3A
X-Envelope-From: <linux-kernel+bounces-541641-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tcEKZu3A
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id A503442827
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:58:34 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 3B9A0305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:58:34 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E8D3BA730
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC00520E007;
	Mon,  3 Mar 2025 11:53:17 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5141F426F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002794; cv=none; b=E3QZf36eajPzrWrn+PAIvIEm3hyTcYUzBSGqosD2JSqMJISCBlKgpcr2GCIhLv+fGoJ3pcmaCHCFKL/tyin8u9SWClp86mc1gTX0i4VAl2GxQWzF5MxeJKhtlxRZ1js4qMVzRGcRKRQcUg0yzMGCzbKc2+ArmwzuMGrOivJM2tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002794; c=relaxed/simple;
	bh=uKlaO0VtSYqlCulEvoLtkmUhyB9oj5gsIjZc4WzZr5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFlwjXE3geUi987IReGrhhlVUnQJeabKaIsfu+yp5Xn9j7v3zpVy9AZv8mCXZpxuCLZvcv2Qje5P/6bPqofJoPVa576bi+vKERINzLNQZZjvxdVHNuvgsWIwH76Oqkbt3o/06PG/sKIzuSC6oOnroYqdej/5D540pNxaes0/Aqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tcEKZu3A; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abffb7b9619so129404766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002791; x=1741607591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtXhuUfoSsHo3hqQz5EZhILyhw+RNyGbAyDJWOR+1Fw=;
        b=tcEKZu3APPhdgjUAY/aHvcuQkgyftTG8+65l130l4oW3yr4NET89g/Yjlh2GJV//9C
         Jou0K+svlQ0InU2V2RPif4ceEhz4eqDgx0CCLtlRWImnnVEWJKCd8EUwd3NOKLjn1wwf
         6POx8Zrz8T+IB7Ysa61iw2gOBRwNCnTmWpmDAxM6odhxiBlXpjg11vAV7ZTxBMG/SGmG
         p8VFseHLZEmVF4OWjnDjHrgR6zZ1uzNVLKvmLRrUMEtadjgnMx+g+aVKSE2lB/Z2bP14
         lGyYr+yoZXohaxh2NRe2YeuFB5PIPfCrC22bEzRIY1LF8lwj43/+aBWlzxoiZjkfZeb/
         YXbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002791; x=1741607591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtXhuUfoSsHo3hqQz5EZhILyhw+RNyGbAyDJWOR+1Fw=;
        b=vxxsSSFbJEY70+CCHaS2mPqWZHsJiBelAGenUPf5OWa8Ku6PWmvW0RGMoJFSVzxrQh
         5L5+xFWztZLqkhB5B4HpuS7j5z1sPlS2qUZN4UQlDIbc4E6NdrYai7EJCXWB0t56HpCZ
         zpMV6tLBT1+XhLi8P8iSqbj/hQAIXIjohCmSGQFY2JZ9yIc+zifGuzEYYnqNvf3qemk/
         4DdOG3EIQUpeez1QIi3eru4qQihdufXxpMAQvpfzWocw62WddlfUrXLo/Nn3rFdOfF35
         2kcEH9T0jxpxF1Wbyb6tzbPSvyWUFDNWMb06Xk1egmfjPVdKlAG/P9VNYml26DrJaRRp
         /ifw==
X-Forwarded-Encrypted: i=1; AJvYcCXXxC2JZT0SfSvTxDtQRlJ9jXkTUfFPidqqgI+TCWjp4Zu9Ug5kLNRJg7EVR+H1A0IgiKqoqljUkNnTHY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28KdnrW26CIFbHZDkLo8xuVOe1wOkhcZiYmTVFpVaQmBP/jNZ
	IrwPJ/SRdge9ugp9xvSiLFepW73PY56dKetFGCIGHhikjjSalqG9U41CeIOiJzA=
X-Gm-Gg: ASbGnctNT9/LtuSt2fAJY00uYS8rRCSBGAF2aLAGwYRhWbugzYFjswWdWCV1cKAzryI
	rV70ccjZhkTBXbaRH7BGu9ofHpWbDfoE7OX/mIOhknw2ChM2UBSIbmZfNR30kwHyic6o2vHK8pT
	CgN+L40wbbDPn3zs+oKzF8swxGn1UDIBsBxivlvPkewk+M2DWOR2/lWcGMeH4dIc/jsrFBU3JWR
	8t2BJUPdqdEZkBR2XstNlcZgIpikADxiRHyfu30fLxQNC0i5wYmwgxHNoh9hKll+xgW5KWmI8Hg
	ijnP7vJN14KHhFSjdDLhsKwFcIkGfZjHEzn0ZFZxUMA=
X-Google-Smtp-Source: AGHT+IFiXqW+Lwb1rqttilbKTCuFqrnwCuwyzVJ/cOH1SDiElNMin3wYFpdUDPax2lPnPWv8bfRXEA==
X-Received: by 2002:a17:907:9717:b0:ac1:e53c:d15a with SMTP id a640c23a62f3a-ac1e53cdb94mr96050266b.54.1741002790638;
        Mon, 03 Mar 2025 03:53:10 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1de83fa49sm86833866b.158.2025.03.03.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:53:10 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 03 Mar 2025 13:52:50 +0200
Subject: [PATCH v3 1/3] leds: rgb: leds-qcom-lpg: Fix pwm resolution max
 for normal PWMs
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-1-62703c0ab76a@linaro.org>
References: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
In-Reply-To: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=uKlaO0VtSYqlCulEvoLtkmUhyB9oj5gsIjZc4WzZr5I=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnxZggiuDOGZkfqUQVY+9AhAVfnorbl76qyE9MP
 JBMYI0CuO6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8WYIAAKCRAbX0TJAJUV
 Vt1NEACPUiQuUoYbNCNbZokEmpQboLB57GjVIEzFMwPmh1FQEiRui9yAA3dOOo+/2l4/d/sY1Nm
 iqGo2Tqn71CiK2WEZhI44HoMD0jJypHcAQIKEKmzLXLTd9GcW+GxCMwXg4G5N2VGLccJY2yKHoD
 vZl/9Gts5SgVB+z+TJgzK5JQLIBotZJlqJTqa2xrJ4GpB+NW91c7OmpgfIaEkP6XU0+0HVKNaYZ
 BopTmw2p+42Heqv29pyGRm+WCTpRFv3PWFLahDT8woEp92Qw+Bu1nj7s+jeVm99zs008LcnyAK5
 gVSQU5RNN8q5XHQ6sv1POSU8N5j+R/c4bY+PdnuAFOtNw87XUULyFcWYIzDSvuCIcHiTSRxvqKM
 SA7+4TxqL6PyMbOr2Xjx724j9pHszGQSkD3q5wth/DlJpu8lphKMH0XpxwVMRoTfwfC0X/Tr65O
 SJiafnT2TiAIa50gTnitnQCaoXGXRiH2Qt2yYrzNKJ/e0zWaFM40KePsqHQQeTr3bVOq5Xygcy7
 y12cIrmJPryAn2SMbO+CFuasEq4XPvcsSHVCKfTRgp5OjTByyR0Ppl7AswN6g4kEB2yxnoo9hXn
 /fR51OFPyN31yZR594DFRNcul687gYj5VPRrklVimZJGrffgLfTwpEM13fgkNQIkF7lJStAsPHY
 C0i0LawvGl2MSJw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gMQ584wzG1ww
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708712.7831@QxCekykFqtZFc7qUTu/zAQ
X-ITU-MailScanner-SpamCheck: not spam

Ideally, the requested duty cycle should never translate to a PWM
value higher than the selected resolution (PWM size), but currently the
best matched period is never reported back to the PWM consumer, so the
consumer will still be using the requested period which is higher than
the best matched one. This will result in PWM consumer requesting
duty cycle values higher than the allowed PWM value.

In case of normal PWMs (non Hi-Res), the current implementation is
capping the PWM value at a 9-bit resolution, even when the 6-bit
resolution is selected.

Fix the issue by capping the PWM value to the maximum value allowed by
the selected resolution.

Fixes: 7a3350495d9a ("leds: rgb: leds-qcom-lpg: Add support for 6-bit PWM resolution")
Suggested-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 4e5c56ded1f0412c9913670699e912b24f3408bd..4454fc6a38480b61916318dd170f3eddc32976d6 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -533,7 +533,7 @@ static void lpg_calc_duty(struct lpg_channel *chan, uint64_t duty)
 		max = LPG_RESOLUTION_15BIT - 1;
 		clk_rate = lpg_clk_rates_hi_res[chan->clk_sel];
 	} else {
-		max = LPG_RESOLUTION_9BIT - 1;
+		max = BIT(lpg_pwm_resolution[chan->pwm_resolution_sel]) - 1;
 		clk_rate = lpg_clk_rates[chan->clk_sel];
 	}
 

-- 
2.34.1



