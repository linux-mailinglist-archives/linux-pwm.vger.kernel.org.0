Return-Path: <linux-pwm+bounces-438-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322B4808A74
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 15:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3551F21229
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Dec 2023 14:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA641C9C;
	Thu,  7 Dec 2023 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6mSC/cj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240239AC5;
	Thu,  7 Dec 2023 14:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D73C433C7;
	Thu,  7 Dec 2023 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701959158;
	bh=BB8B5e3lcX0yXeV5twd8WMzv2yRfLB0d40M15sMzN1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6mSC/cjKDFaqugND65JRTmW92mbljTgTTmg6CGaAWNF0WL82rxgt67mmfiMxerqK
	 rJ4P489cZCnC7C3g2l5oP7kQ2XzO/AXyIRNsDzFY/Sj44qg6AfCgNI8qMpNpWvkdho
	 rqqiksxl7IPdOkeJKAnFsIKaBo5BPRYalNd6/B6/N3Wd+oZM40WlVLf1S4+8eXvq4T
	 pbJzP4yk44WEsLM8O6Kx2S123xf+VKdn9YNvZDyA89Rsa+d9MKgQmX9RazBaFt6HNp
	 suPFRquwASN0RSww3bbJSYv1LpBkuG+objnLfTJWlYzwIGw7esFaBIx4YcQB4x9d7a
	 7uEGlhVRRzmDg==
Date: Thu, 7 Dec 2023 14:25:50 +0000
From: Lee Jones <lee@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
	thierry.reding@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev, luca.weiss@fairphone.com,
	konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
	quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v7 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
Message-ID: <20231207142550.GD8867@google.com>
References: <20231130013615.14287-5-quic_amelende@quicinc.com>
 <17a8a637-3477-41fe-959f-7784cf6d6b2e@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17a8a637-3477-41fe-959f-7784cf6d6b2e@suswa.mountain>

On Thu, 30 Nov 2023, Dan Carpenter wrote:

> Hi Anjelique,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Anjelique-Melendez/dt-bindings-soc-qcom-Add-qcom-pbs-bindings/20231130-094701
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20231130013615.14287-5-quic_amelende%40quicinc.com
> patch subject: [PATCH v7 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
> config: csky-randconfig-r071-20231130 (https://download.01.org/0day-ci/archive/20231130/202311302200.RcTP9m0Y-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231130/202311302200.RcTP9m0Y-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202311302200.RcTP9m0Y-lkp@intel.com/
> 
> smatch warnings:
> drivers/leds/rgb/leds-qcom-lpg.c:1055 lpg_pattern_set() error: uninitialized symbol 'lo_pause'.
> drivers/leds/rgb/leds-qcom-lpg.c:1056 lpg_pattern_set() error: uninitialized symbol 'hi_pause'.

FYI, I'll not review this set until these are fixed.

-- 
Lee Jones [李琼斯]

