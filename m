Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693097BB36D
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjJFIpH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 04:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjJFIpH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 04:45:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F89B83;
        Fri,  6 Oct 2023 01:45:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae75ece209so352471666b.3;
        Fri, 06 Oct 2023 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696581904; x=1697186704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiQG9eB+81jnnKh5yBXb7DYjjmAPfSYQYgGlMxFuycQ=;
        b=Kp5+Uha7qWwlKpAiIeTeA0zBoHwgd2BmOHRaCFW+WwCP+1lADq/WweqfkH9Cics/fK
         8MEo/z7TABDt/edznmniuSZ+ao11TkYUSbdEHwa6oTOiA46ygrecH25FffRb6xG6Lg7B
         iJ3zwHZZm5Dwj8gQSpg7pr7TX3H+bOXOuL98E5A7oxY2xNd/n1Wvj693akD5/Kf0DevU
         OyaJQcMtYYVVi8TKsQx7AG2WWJKiKq669ftpmi8Gv1nMe5T9tMC3adN/KAiLRZ1aZQ+8
         krMCb0qj7LigwBH1WnNsmrrpphLZkJ9AqkGjeYFz3EnqeUI8BRQmMQ0hJvOWFXNoyJmJ
         byqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696581904; x=1697186704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiQG9eB+81jnnKh5yBXb7DYjjmAPfSYQYgGlMxFuycQ=;
        b=ef3xPd1XMm2RiNI0eijP5CGcMjbtSal24QYvDJYk0EASvuDQPkFoQt8tWJeLaF07DU
         Nbelih9qLtRi/u9QnU7u6sVFikGLVMaTOa+grwubJ1QdsLAWVRbMUqGJ762ph3Q9VHu/
         A1qC+87XeCGimR0cmtrBthVgcI5DRAvAVPXe/JDwsWGHIFPqIo2glECoPkpTneob8QdK
         UxmP7Ap9XDsxjPpdj8RbYUJ+bGYrrpZ1xRk56C4z3XfkOZL9eIhIwvgj/+gd7eO2U2XH
         fyokOcg83Tm0fm3e/TPaz9qcBwad41lugp9Jws+bj8diQA3A3hVxVPM8rc6DGJ9VdXYz
         BVFg==
X-Gm-Message-State: AOJu0YzpgpYIY+nYmS503Oj471rkY3mZrwl2xkertcATtxmAjtWbOYB9
        JrQgAT/feyUtoQY/gNgnlDk=
X-Google-Smtp-Source: AGHT+IG7gav62CWXqgxy3Oc+Bt9zEBpNR9pS09uNaXeA3kHMd6ruw2I+CKCVmI2UXUURkmYPneMOlw==
X-Received: by 2002:a17:906:8a71:b0:9ae:3d75:4c83 with SMTP id hy17-20020a1709068a7100b009ae3d754c83mr5879512ejc.0.1696581903844;
        Fri, 06 Oct 2023 01:45:03 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gr22-20020a170906e2d600b009b2ba067b37sm2467713ejb.202.2023.10.06.01.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 01:45:03 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     shawnguo@kernel.org, Fabio Estevam <festevam@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: pwm: mxs: Document fsl,imx28-pwm
Date:   Fri,  6 Oct 2023 10:45:01 +0200
Message-ID: <169658188181.78451.16194002929003687751.b4-ty@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922124229.359543-1-festevam@gmail.com>
References: <20230922124229.359543-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Fri, 22 Sep 2023 09:42:27 -0300, Fabio Estevam wrote:
> imx28 uses the same PWM block that is found on imx23.
> 
> Add an entry for fsl,imx28-pwm.
> 
> 

Applied, thanks!

[1/3] dt-bindings: pwm: mxs: Document fsl,imx28-pwm
      commit: c3c653422a265a3b5dfdf8567eebd5116311c36d
[2/3] dt-bindings: pwm: mxs: Document the clocks property
      commit: 42b9116ce12579692ec18ad9446ea5ad832ea0ef

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
