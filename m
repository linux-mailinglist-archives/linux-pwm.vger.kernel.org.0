Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC406C6A17
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Mar 2023 14:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjCWNzM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Mar 2023 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjCWNzC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Mar 2023 09:55:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1666192
        for <linux-pwm@vger.kernel.org>; Thu, 23 Mar 2023 06:54:59 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r11so86939655edd.5
        for <linux-pwm@vger.kernel.org>; Thu, 23 Mar 2023 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679579698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMJxQ/6YTCARwHon/HB0Jx9jI/niUWUw/WYvloTBvDg=;
        b=eoC5jSrIPVKLwkoJOx0YQ4yRTaXKjRVyzxfT1HbYhhAt/o0yPl70dSBWdCb1dmHcGu
         x2JaZU20AJXiYTkLDmhn5q/AITxCu6FnqmJNIn1djHZiUSJTnwKoBlVwT/6IlYjEu9bf
         zpPszDKNl5j37idTXkJ0LfjQYm8+m75xsOCQi8BJp24+qs814JBXpnGfpYu6YaPl2bOf
         T0guz02ADHYidgZBLWgqL+bqDsxCBB3s2zsTbUxym7ni6g9e3fZQjQnAkLKPQQSdxDks
         AYLZT0iN6rBVUZz0e4L+0brCwiZVRkclOKPuKJ6CBBRpB51pGQWozRh88hDEaIH4UZjI
         0xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679579698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMJxQ/6YTCARwHon/HB0Jx9jI/niUWUw/WYvloTBvDg=;
        b=vqQGSgnyEeoNSc5WTSQ8O+55evn8S29tlq9cCLUkttcU0P5Vh27OqBuM3pJqkwAQkZ
         O4KRs/HkuPkSMdTNI6VJKAZJ/J0pZboZKAFbekB/sO5M7+8xqGNidvp3cwtjv2nqHNbX
         aJr8nU+wsHFMgzlS9dC2erXlsMis5KYcaYXfxJ+MbOECoE4EoVEUE5kRr2shv3ICsaR7
         J60TkRRs6vNFN9iGE4jDYgKM0rFOd69lox8mf0LE0Mo8vHqaPTcYEiY+VpwEfLKvVawf
         Jnhw+0VxK97wXqqogefJ2b/PWoTYavEfa5i8qYrx7rSw3mPT6T8+uCIeboZVU43Qg6jm
         Ygpw==
X-Gm-Message-State: AO0yUKVYfLB8yraAPmKSZJbWgOQ7/Au6iKnUrV8agomuK/M5+mbzMYsF
        lbYslk58mjQ/0Utf0s4+rzE=
X-Google-Smtp-Source: AK7set9zC7IVj3sJAr0nXR/H3vqLvy6HyR0ijEzLrmi4lKhwXKgTE4euGwM2rlKoxEgg0DGSkZqU9Q==
X-Received: by 2002:a17:906:510:b0:91e:acf4:b009 with SMTP id j16-20020a170906051000b0091eacf4b009mr10444587eja.22.1679579697683;
        Thu, 23 Mar 2023 06:54:57 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id tm8-20020a170907c38800b0093c82edfd48sm1215624ejc.80.2023.03.23.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:54:57 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=EF=BF=BD=EF=BF=BDnig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL] pwm: fixes for the 6.3 development cycle
Date:   Thu, 23 Mar 2023 14:54:56 +0100
Message-Id: <167957967134.538085.6134381208938195065.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <b4-exploded-0-20230322214539.vbjpsqnlvhagiibd@pengutronix.de>
References: <b4-exploded-0-20230322214539.vbjpsqnlvhagiibd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 22 Mar 2023 22:45:39 +0100, Uwe Kleine-K��nig wrote:
> the following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.pengutronix.de/git/ukl/linux tags/pwm/for-6.3
> 
> [...]

Applied, thanks!

[1/6] pwm: hibvt: Explicitly set .polarity in .get_state()
      commit: 6f57937980142715e927697a6ffd2050f38ed6f6
[2/6] pwm: cros-ec: Explicitly set .polarity in .get_state()
      commit: 30006b77c7e130e01d1ab2148cc8abf73dfcc4bf
[3/6] pwm: iqs620a: Explicitly set .polarity in .get_state()
      commit: b20b097128d9145fadcea1cbb45c4d186cb57466
[4/6] pwm: sprd: Explicitly set .polarity in .get_state()
      commit: 2be4dcf6627e1bcbbef8e6ba1811f5127d39202c
[5/6] pwm: meson: Explicitly set .polarity in .get_state()
      commit: 8caa81eb950cb2e9d2d6959b37d853162d197f57
[6/6] pwm: Zero-initialize the pwm_state passed to driver's .get_state()
      commit: 1271a7b98e7989ba6bb978e14403fc84efe16e13

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
