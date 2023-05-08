Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626DE6FA377
	for <lists+linux-pwm@lfdr.de>; Mon,  8 May 2023 11:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjEHJhc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 May 2023 05:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjEHJhb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 May 2023 05:37:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B4A1709
        for <linux-pwm@vger.kernel.org>; Mon,  8 May 2023 02:37:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bc570b4a3so8179108a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 08 May 2023 02:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683538649; x=1686130649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBtL4cWfszS4ROjDUwHjteKkG2Q8u0EKVxKvzxIQ24U=;
        b=rO0e9rufK3H4pXHtw79hf7tFhQ/KXkAJ7HhbxEGTEUZOYRsfrbfFhWS3W3mrExakFb
         atjAxhsdiaGKYerczIA1inr6agUwB+h8/helKWZL3zBu/NK3sHB7Ry/A7zQ5EE40oA8B
         K6yG+GuFAS0DZWJ0FJxVVKHJxIElqWo6jFoAhXUq0uhTPpCU/uU8cfmMP6RZh/9igune
         XVWRIizvq54VgxQxsQ4nQ3njArlZnBVrqQuJvoiDlvO1bpnquItReUoo+kP7cW7NLFWD
         0ryaHhWGumGjHo2JFOvIu85emj2G2S23orb1OoOBoqFhKKsjKG0xp4DfD1Eql+9GtMQ2
         LLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538649; x=1686130649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBtL4cWfszS4ROjDUwHjteKkG2Q8u0EKVxKvzxIQ24U=;
        b=Uakd9PQOimL/dZ9YNXNYRFsebVcQfTY6nxZSchxrRGRfdxSxQmMn24DW6C2vPnwmO8
         tRZlW3eqM3x8d0E0e7soLLlTq9T+WNinTn7PmTkercpwwK7zcLDK5lvPxPC3yvWbh0my
         efwQmzGUZlIFPmLAg0DCBnR21wOnDrVqO6MT0Oi32He+rlnjSmgYmkGt3c4i5hb0Vd57
         akxV71VQcg7WGozU+2whVFx1FQ9kgOIwxoiJrV2IiQfXSU1+RjJGg/vlJbWPedNqXhG4
         3g0bFBI237wkFwB0pCby9NTl+GqeNN/GQNtZsMF+KxqQkZMvStjPUiTgJ/PhmommxRee
         5hDg==
X-Gm-Message-State: AC+VfDyHK9/HM9xTDyRXGrqZBe6VpGwkHW816Efe1fQYc1MZ0c5OUrNC
        +ijeXL2tICY6e3aekrnZNE974A==
X-Google-Smtp-Source: ACHHUZ5h0ILKxQCVccGldVRtqE6oDI4WtFhK7pSgdSbqQ+S4aV452b+GEAJJS+jVaXLbJcss3YfSEw==
X-Received: by 2002:a17:907:8a13:b0:961:2956:2ede with SMTP id sc19-20020a1709078a1300b0096129562edemr8911942ejc.44.1683538648932;
        Mon, 08 May 2023 02:37:28 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id h13-20020a1709070b0d00b0094efdfe60dcsm4649244ejl.206.2023.05.08.02.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:37:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sasha Finkelstein <7d578vix8hzw@opayq.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        asahi@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust file entry for ARM/APPLE MACHINE SUPPORT
Date:   Mon,  8 May 2023 11:37:25 +0200
Message-Id: <168353863936.84657.5087723574907362646.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424114043.22475-1-lukas.bulwahn@gmail.com>
References: <20230424114043.22475-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Mon, 24 Apr 2023 13:40:43 +0200, Lukas Bulwahn wrote:
> Commit de614ac31955 ("MAINTAINERS: Add entries for Apple PWM driver") adds
> an entry for Documentation/devicetree/bindings/pwm/pwm-apple.yaml, but
> commit 87a3a3929c71 ("dt-bindings: pwm: Add Apple PWM controller") from
> the same patch series actually adds the devicetree binding file with the
> name apple,s5l-fpwm.yaml.
> 
> Adjust the file entry to the file actually added.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: adjust file entry for ARM/APPLE MACHINE SUPPORT
      https://git.kernel.org/krzk/linux-dt/c/196a1716a2ecdcbc61e6b299362897f0ccbd26c1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
