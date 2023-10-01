Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B87B47E8
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Oct 2023 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjJAOP6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 1 Oct 2023 10:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjJAOP5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 1 Oct 2023 10:15:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFAAB
        for <linux-pwm@vger.kernel.org>; Sun,  1 Oct 2023 07:15:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a65f9147ccso2120652766b.1
        for <linux-pwm@vger.kernel.org>; Sun, 01 Oct 2023 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1696169753; x=1696774553; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DdqFn2Z3bHJeGohpJ3zhXHAdEVBVwH1IEgmvBHO5so=;
        b=5CRJObg0cpw0c7qP/N3Vdv55MFb98rUPxv/QazH/Uq1XhtrgCjjc5GkPycpXSb4xhJ
         C+A3Rk6Kj/FBgMMH8uTcZfAkoFjHldkFQI5fF45AyI3ZUsvqW6AK+AJvISRPA17uKtm0
         eiXHTW+VhXu4cZ7b0KL/IaXZWAAxel7Vvb+tQC4XH9S7xMz4nr78SyFxF7KcUnUJIGU/
         gawRSyh/XX6u56oJRlIOW4SJkTma68CR4SkbRF3ZDVwcA3Hg2Tp/x+kJUoFvav8+RZF+
         mtI5RCLBjuJFNoqURB0A2+nR/gC3G/hT0nUxf7fQIfd7Obyd77bofpd2uwhQULsDmBNY
         upPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696169753; x=1696774553;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4DdqFn2Z3bHJeGohpJ3zhXHAdEVBVwH1IEgmvBHO5so=;
        b=gxWqYs4Bu3tG1ARqEWRzwbbo/AhMEClZSkL5SQl4Z85osuKndqN3Vb4/t7uicC/Wpl
         tU2DXc7fWtEVN926bygc34dpv0cE3iuHTaZgqOEEwCnKdmLhtde+v3k6QngLWKYluCAQ
         6GEPfIlLGzY465E65gsp5AgEWEvnyLCjmFsRsP0mznTl6IHnjJFcxXHnpVAtCXsISUrt
         bjtu2HUJjwnns9nvS6+NU+zdFwvThKO1bPDIrCjJ21AZyZyPj7SPW7XbsJtv3OHfVl/W
         IdeCydprrKwd93yIYlNXBPxoAVMzVdbI55Hf9wqB7/b9jLeY1rPCklwq4JuBuBkgwsNq
         Unqg==
X-Gm-Message-State: AOJu0YwIy6p60ZQhXEFy/x815XiqdC+Q2wBk1agUGK0Bnyw4wd5R3HhW
        J8ktePcEkYCwTQ0eFM3bp6NHbQ==
X-Google-Smtp-Source: AGHT+IGfkqrZpht21J94fVHX40sis+d2WV+7LP64gzm7OfSZf+TfpiTrv+Tt+D/AwQLcsMTUv3Fdiw==
X-Received: by 2002:a17:906:51c9:b0:9ae:6355:5ef4 with SMTP id v9-20020a17090651c900b009ae63555ef4mr7661552ejk.3.1696169752514;
        Sun, 01 Oct 2023 07:15:52 -0700 (PDT)
Received: from localhost (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id c6-20020a170906340600b009b2f2451381sm2345488ejb.182.2023.10.01.07.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 07:15:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 01 Oct 2023 16:15:50 +0200
Message-Id: <CVX5ZUGU9BVE.2TA819U1AI6BZ@otso>
Cc:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <quic_gurus@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <kernel@quicinc.com>
Subject: Re: [PATCH v5 0/7] Add support for LUT PPG
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Anjelique Melendez" <quic_amelende@quicinc.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
X-Mailer: aerc 0.15.2
References: <20230929003901.15086-1-quic_amelende@quicinc.com>
In-Reply-To: <20230929003901.15086-1-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri Sep 29, 2023 at 2:38 AM CEST, Anjelique Melendez wrote:
> In certain PMICs, LUT pattern and LPG configuration is stored in SDAM
> modules instead of LUT peripheral. This feature is called PPG.
>
> This change series adds support for PPG. Thanks!
>
> Changes since v4:
>   - Patch 3/7
>     - Get rid of r/w helpers
>     - Use regmap_read_poll_timeout() in qcom_pbs_wait_for_ack()
>     - Update error path in qcom_pbs_trigger_event()
>     - Fix reverse christmas tree
>   - Patch 4/7
>     - Get rid of r/w helpers
>     - Update variables to use "sdam" instead of "nvmem"
>     - Fix comments
>     - Fix reverse christmas tree
>     - Update lpg_pattern_set() logic
>   - Patch 5/7
>     - Removed sdam_lut_base from lpg_data
> Changes since v3:
>   - Patch 4/7
>     - Fix function returns
>     - Move register definition to top of file
>     - Revert max_brightness and probe accidental changes
>     - Combine init_sdam() and parse_sdam()
>     - Change error prints in probe to use dev_err_probe
>     - Remove ppg_en variable
>     - Update when pbs triggers are set/cleared
>   - Patch 6/7
>     - Remove use of nvmem_count
>     - Move register definition to top of file
>     - Remove lpg_get_sdam_lut_idx()
> Changes since v2:
>   - Patch 1/7
>     - Fix dt_binding_check error
>     - Rename binding file to match compatible
>     - Iclude SoC specific comptaibles
>   - Patch 2/7
>     - Update nvmem-names list
>   - Patch 3/7
>     - Update EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
>     - Fix return/break logic in qcom_pbs_wait_for_ack()
>     - Update iterators to be int
>     - Add constants
>     - Fix function calls in qcom_pbs_trigger_event()
>     - Remove unnessary comments
>     - Return -EPROBE_DEFER from get_pbs_client_device()
> Changes since v1:
>   - Patch 1/7
>     - Fix dt_binding_check errors
>     - Update binding description
>   - Path 2/7
>     - Fix dt_binding_check errors
>     - Update per variant constraints
>     - Update nvmem description
>   - Patch 3/7
>     - Update get_pbs_client_device()
>     - Drop use of printk
>     - Remove unused function
>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3 (=
pmi632)

Hi Anjelique,

Actually I've retested this now on PMI632 (and also realized that my
previous tests weren't correct and wasn't actually using hw_pattern).

Using the following commands (after boot) I'm expecting to get a
500ms on 500ms off blinking pattern between white (255 255 255) and off
(0 0 0).

  echo pattern > /sys/class/leds/rgb:status/trigger
  echo -1 > /sys/class/leds/rgb:status/repeat

  echo "255 255 255" > /sys/class/leds/rgb:status/multi_intensity
  echo "255 500 255 0 0 500 0 0" > /sys/class/leds/rgb:status/hw_pattern

What I actually see is it blinking between cyan (0 255 255) and red (255
0 0).
At some point after playing with many patterns I got it to actually
cycle between white and off, but I couldn't reproduce this again (or I
didn't try hard enough).


But with this example it correctly blinks red on-off.

  echo "255 0 0" > /sys/class/leds/rgb:status/multi_intensity
  echo "255 500 255 0 0 500 0 0" > /sys/class/leds/rgb:status/hw_pattern

With "0 255 0" and "0 0 255" the other colors also work fine, it's just
the combinations that seem somewhat broken.

Regards
Luca


>
> Anjelique Melendez (7):
>   dt-bindings: soc: qcom: Add qcom,pbs bindings
>   dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
>   soc: qcom: add QCOM PBS driver
>   leds: rgb: leds-qcom-lpg: Add support for single SDAM PPG
>   leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
>   leds: rgb: leds-qcom-lpg: Include support for PPG with dedicated LUT
>     SDAM
>   leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme
>
>  .../bindings/leds/leds-qcom-lpg.yaml          |  89 ++++-
>  .../bindings/soc/qcom/qcom,pbs.yaml           |  46 +++
>  drivers/leds/rgb/leds-qcom-lpg.c              | 359 ++++++++++++++++--
>  drivers/soc/qcom/Kconfig                      |   9 +
>  drivers/soc/qcom/Makefile                     |   1 +
>  drivers/soc/qcom/qcom-pbs.c                   | 243 ++++++++++++
>  include/linux/soc/qcom/qcom-pbs.h             |  30 ++
>  7 files changed, 749 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.y=
aml
>  create mode 100644 drivers/soc/qcom/qcom-pbs.c
>  create mode 100644 include/linux/soc/qcom/qcom-pbs.h

