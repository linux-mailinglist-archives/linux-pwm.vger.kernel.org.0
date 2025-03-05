Return-Path: <linux-pwm+bounces-5102-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26837A50013
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 14:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17558168FF4
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Mar 2025 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265CD24E4B5;
	Wed,  5 Mar 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYIFdZ+F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74824E4A9
	for <linux-pwm@vger.kernel.org>; Wed,  5 Mar 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180164; cv=none; b=MZyXHvgVetNWRhG4RzoHp0G8tsheqGwXrYaK9PESuup3Qdt2JuPJpyfkys23ZXs3hS9HiNPqBEHvzt0bFFdwbeFyfuvSMb2GqQ3p6QvkKPnVSvtvoYS2tKeunqCqUBBVMCXeZSrzJrzeoK/IXz7p0R11/NVdWmhRXyGzwa1bDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180164; c=relaxed/simple;
	bh=SuvVmJ4Sr+a7dK1Ic2JXgHQ9vplQfscMsmavcbKN2Tg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PWlGyPsUn82sLHvE+w4sxzLdRvS3YZrnvKRUVTgneCjci7NlwSrzo8Doo/NlWVTp40cJyC0jL1lSty4+nokKlrnnWBIV6X5JAATBQrl0SCqjWLO6NLoLdBPr3U1nfZWFD7c9wxStDGwiYvK8Tm8I4RqwtHOy4iAKFEewGft1d6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYIFdZ+F; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso11119082a12.3
        for <linux-pwm@vger.kernel.org>; Wed, 05 Mar 2025 05:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741180160; x=1741784960; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEX90oUW0TXTnfvsLPGvaD0pMBzwyn6s3WqQHJ4nyns=;
        b=mYIFdZ+FqZD9zRzlCi81lBQ3Y1LD6WWmwots4EUPODGbgAYuEgvCdK/OeE7GUjZDQR
         2yhgPMw8Bfn7PGXWdvwXeLBkBpG8EvmUIl+/sUw5GfVIuWs4h2VzkBI1UwyJKCi0hoi/
         Amg9nggcsuWNsB0zNWwGdX+Kq4QizOq+659brDy/A4lcMsoOYT3upP3Mw2RVn6N8aZ5s
         rfQTgf4jxPcybXlAZmrwqmyDvXk6rXx/jdRe6U47oB3wBeSeqNNmrgzIRqz5A6llkhTw
         Spl/ioJrXjYb5DxQGN/R+p+qwp1SfaSqvQemFm0A+HogiffbIIVlm9AD8NF8j+RyKnzO
         r6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180160; x=1741784960;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEX90oUW0TXTnfvsLPGvaD0pMBzwyn6s3WqQHJ4nyns=;
        b=IHkkfPHi2DVu2wA9FQ4PpmAn1eTZGKqHbYFMGiapzeg6EYrfPka+ibMYula4HwKOlY
         hON9bpftfdhGwaeBhdmCwskqvrcCEgB9zu0GEAqlk0LrJF1Fc5ZMg9YUxAr7FrWbOhmq
         240dmhTEESIsND4yk4k3ZStM1AAK5HOkS7dSI97kEuVR7YKZJ5jivfW4ku7bTkSmTto0
         1dp8ja4HHdp5lRVR6FPpL8ORuTyGTJv4VS9vUT8LcmIfx99rnLNSmcbKmQqytcn3LVpI
         9y4zbtuXOIGpDc+8OnsUWarA7oKAYU+XJ6Pj6nPhRO8FA/yOAQDM/pcGsUTK2wl9yIsl
         z3yA==
X-Forwarded-Encrypted: i=1; AJvYcCWxsrmcVag5uw52a30Y/tETsA3omLo9bRLYkS+mql9+/Kpn4Xln04ZWezLc6yeb2kZf6yfgEBx1iVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qZhFsZJJqTBFrV53nMGaq1xAoRSFFEeLRb3KJdVCb+B0rK74
	pn4nUnoOdqtmAlilSlmRUgocv6UZAWMNwpO9M2llfPWNSJFLMcRnetOdpmEFWt4=
X-Gm-Gg: ASbGncvtYagYN4ehu3Q6P59CeNalJjeTBv82n7Cs017p8SD22kkeM6tNu9Md/W96bIP
	Q1bYQwkxp6zcDejxlSPffY8pEwrs2LQm31wiSG8+NRcKesoVEhTUXh3lwQkXlDFggmos0XmAkNv
	oC/zGCDwCeeaTW3pCK0whOXsY4EiXua8eG3HiNexuVJH64M0ZWDxMHPNipNC6gv2kmyPoxnMS+c
	hgfxHrBUpJpp7AbieSMrXkpBoYWWROnP4A4FIyfsZii+ZNTmcpFnnUGI5PZwrF2HGThobg8SuYK
	4cPD5OcfdrjSY2aU1AKsq01fVjqJy0fLOk17J8wXRyk=
X-Google-Smtp-Source: AGHT+IE4rWTzsTxolX8cDUpaOUjiyqUJYJo5sUXRRhBSYUaZ/i3/G/CNpWjxTqUs7xmXYXkpR2yVpw==
X-Received: by 2002:a05:6402:40c3:b0:5dc:74fd:abf0 with SMTP id 4fb4d7f45d1cf-5e59f3c4179mr3367598a12.15.1741180160053;
        Wed, 05 Mar 2025 05:09:20 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aa5dsm9627341a12.14.2025.03.05.05.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 05:09:19 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 0/3] leds: rgb: leds-qcom-lpg: PWM fixes
Date: Wed, 05 Mar 2025 15:09:03 +0200
Message-Id: <20250305-leds-qcom-lpg-fix-max-pwm-on-hi-res-v4-0-bfe124a53a9f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9MyGcC/5WNwQ6CMBAFf4X07JptKy168j+Mh1JWaAIUW4MYw
 r9buBhvepyXl5mZRQqOIjtlMws0uuh8n+Cwy5htTF8TuCoxEyhyFAKhpSrC3foO2qGGm5ugMxM
 Mzw58D42DQBFQaSp0IYw+liyZhkDpuFUu18SNiw8fXlt05Ov6n3/kwMFwxckqjWTyc+t6E/zeh
 5qtgVF+pBLlb1IJCEpolBZNqZX5ki7L8gYgw2MxLAEAAA==
X-Change-ID: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b
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
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2168; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=SuvVmJ4Sr+a7dK1Ic2JXgHQ9vplQfscMsmavcbKN2Tg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnyEz2RKjNcPuwHvWMtD9dfjX5mCFVFRA0/6pPT
 jlNDAjN3jaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8hM9gAKCRAbX0TJAJUV
 VsGZEACu5byabqhkkSI6jU9QtHlwmy84dTvZMdeRqo0BCDXFdyO/ZqV1iOE9Tgx8jcvip5ATFNg
 h4gdWfQULDLRKiBsRofnPjeydLHB3JNd89B4zFgCoO5SNBI55Ro9LAytV1+sTDOLv5M6re5goaZ
 1OdaetMG89v62u/VBIE7d71wq5PiFlqE3LxGY+K4dWCcaM8VqCjzXfE4qkkTxj2GwqGj8K3c+5+
 T8DJa5aFaveQbYMGbq8sYvDP6VAIXBxHQW7KtxFldWbVyUnHB6IWvbkH0VnzjLZ5sDmbf1LpH9q
 4lyHlJzZQi+2g1fHSRxwyqza/mhRyqwrDykLOiFjrVlVJQYSW82gQFtjlRorsjq4FvtrHHm4Ebd
 eAVqPyW8ZJDPPHhSI/kAUzYKwUbdAWGZarYemJDCUuI5oHwaJD8T9Y2fvO0+UCyN5yMse+HUYcS
 87Egf6UqKoP9Q21yMc7Fkb27aBjMJR5Iaq7Ec4wLlZs0pesHxjhgQVaZKyCY+qOr+jUYn/j/uYk
 tVoqf6q01axzTL5+1zwMyucvcQYpyTHX/KB1Lm7qqdYZTnIE1e0OEfHTDczFnhY+CYO0Gc1F8En
 CBAG85BMxY5fdCtMLgHSQrapoJcgg4uLNvUCM73Ci/E6UE7abRZ3cvfWeTwzEY/qJMDXucktseE
 hNOqhPivf6sZPWg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The PWM allow configuring the PWM resolution from 8 bits PWM
values up to 15 bits values, for the Hi-Res PWMs, and then either
6-bit or 9-bit for the normal PWMs. The current implementation loops
through all possible resolutions (PWM sizes), for the PWM subtype, on top
of the already existing process of determining the prediv, exponent and
refclk.

The first and second issues are related to capping the computed PWM
value.

The third issue is that it uses the wrong maximum possible PWM
value for determining the best matched period.

Fix all of them.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v4:
- Rebased on next-20250305
- Re-worded the commit messages for the first two patches to include an
  example that should better explain what the issue that is being fixed
  is. As per Uwe's request.
- Link to v3: https://lore.kernel.org/r/20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org

Changes in v3:
- Added a new patch that fixes the normal PWMs, since they now support
  6-bit resolution as well. Added it as first patch.
- Re-worded the second patch. Included Bjorn's suggestion and R-b tag.
- Link to v2: https://lore.kernel.org/r/20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org

Changes in v2:
- Re-worded the commit to drop the details that are not important
  w.r.t. what the patch is fixing.
- Added another patch which fixes the resolution used for determining
  best matched period and PWM config.
- Link to v1: https://lore.kernel.org/r/20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org

---
Abel Vesa (3):
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for normal PWMs
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for Hi-Res PWMs
      leds: rgb: leds-qcom-lpg: Fix calculation of best period Hi-Res PWMs

 drivers/leds/rgb/leds-qcom-lpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: 7ec162622e66a4ff886f8f28712ea1b13069e1aa
change-id: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


