Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7E62DB47
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 13:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239662AbiKQMkL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 07:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbiKQMjW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 07:39:22 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5055F742C2
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 04:39:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p8so2540058lfu.11
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 04:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugMBQI/CGdLw5JdCEtKoVTwaKmCj5RmUXEMoLxKIBbk=;
        b=lcPHPPZLPVoOh2gvUJWQXtKOOX+svrikFq3/iElv3IWxcU7NSiqM7IOaXs2C2lE1LK
         NQ6Mz7EYFwXmyDOarXfupzphKJE/2muZN5dpHj1Ji5Q/l0UvY0bO8CFrfHvKOBMiI+uN
         S/TPz9ieFvvfxxdSXt3WhiyXNJV4QoFZ1g+PkzZ+mDds6QZ+7D2h1GyWPOXifD82XpBi
         Ft6RfBe9attwb737JofFZOKfzoS5WAjTDxQE2vnp0UKggWaxApdqploNwzYw1yZdrnuJ
         YtUxd6G7fjvoTeu+xeLg+/kPu01LnjMI5ELRkq/DhmeqN5xwLzMsfXJDlWkL7wtqmLEL
         96kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugMBQI/CGdLw5JdCEtKoVTwaKmCj5RmUXEMoLxKIBbk=;
        b=h8RS80VWqHxDKyNj5halYZV0e6m54q/A2oNrj4ZuiJouBmlEVaqb5JzRIOAVnffDNF
         pNRlUsxZPcGD+k5zwkom8heJEKU+eZ5OALwJVqESrsB/rQf8bITHVQMQdlFpmmtO5xIb
         joDmeO6ylbzA0AJ2uxVUFqeD2VCWAoW6MFDCmGvFcZxgo8JyfinDGz2cYHd3WuddAb+T
         HkG6h9yjKoieLG7Xm9QTT2YWbnA+x9G9no5TjoKLIznucNLy854qySIqfs+00E2lZoWR
         qETl5Vvp+p16D9Uh07K8t5NtMrUIr/NfpPUV8ephUC0t0+b1gZ5w8pp1lD48hI6Qb301
         xN8A==
X-Gm-Message-State: ANoB5pn5MQQXWBBXGyF/WecpnPgg+fK2WFh7V1RfWUMQ5iB3TFif+9LI
        tdCqRSDwTIHdv4Dkj8+44naSPQ==
X-Google-Smtp-Source: AA0mqf5J4zgczTAjGCzd24Jcix6qL84UxPJ/LL1MaY0euJIStPemkPT1hJEMAHEevs8ExijdUCjPEQ==
X-Received: by 2002:a05:6512:746:b0:4a2:4f74:f47c with SMTP id c6-20020a056512074600b004a24f74f47cmr773458lfs.367.1668688748094;
        Thu, 17 Nov 2022 04:39:08 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b004972b0bb426sm127855lfq.257.2022.11.17.04.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:39:07 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH 2/9] dt-bindings: memory-controllers: ti,gpmc-child: drop redundant part of title
Date:   Thu, 17 Nov 2022 13:38:43 +0100
Message-Id: <20221117123850.368213-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Devicetree bindings document does not have to say in the title that
it is a "Devicetree binding", but instead just describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/memory-controllers/ti,gpmc-child.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
index 4a257fac577e..532a91d6c564 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/memory-controllers/ti,gpmc-child.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: device tree bindings for children of the Texas Instruments GPMC
+title: Texas Instruments GPMC bus child nodes
 
 maintainers:
   - Tony Lindgren <tony@atomide.com>
-- 
2.34.1

