Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EF4766598
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjG1Ho1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjG1Ho0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:44:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12A7B6
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so381533566b.0
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690530264; x=1691135064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzCM3bup9JYRIhMtvPNppw+otOi0bz3tqJa5kaDJQBg=;
        b=mKWRiTOisRDYtEG8UqaRvKb5kRYTbGYpjyDL6MrKzrdneLHjeJJYf3AtVmcBf3zLnx
         1ScqDt+C6LS9j5p1tgxUbWRdyvAgmxwtPffIi330tSTuKKgqyIfdyOk8UsQwhShdMHPg
         DryVCqeUweUwi4+ms8Gjwj+Q1XKaLlfZc+I/BnFgo+tTDhaFyk7H7pG1+XYfULlme+4K
         OAdE0F1cvHbuX1dOxEp87bwoZBFmZZLv0V0LA8/KK7JYD2INAFkCd7SeaGnFJz4q/t4O
         Q7wlx5Uni3XIQKDM8sqPzU4ICQNnsdRyH+H2cVBBdKYilb110/CAUpEbWm8OqB8zNnno
         VSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530264; x=1691135064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzCM3bup9JYRIhMtvPNppw+otOi0bz3tqJa5kaDJQBg=;
        b=dtPIfoKUC3nOneeCxnKAWrzRUG9VRr54/wNqbEJSODj1mNJyvdskMlX5RpXwSPTU1j
         hmMuWEd392SG7cFinGajgPwFKfix1rth62tAVcmspi/BiuvC4xpZzCnzWpvv+BM54WnE
         BPqzM7YfoVNhz3xrTgs8LAGUGDxY4nyVp98DMptq7+frM5HHCfzUl3yAPdSfPOex1P8o
         RdCXkYTBxJbcfXQz+kL45HyNSo8MI59SOzT0HYbtfrNlCKzFVZiawkJOOfEq0YSb4e5J
         hawM95/FOTfI6jWMdHFiLOyRPOYMujh3Vdw5XVBdbfboNtPSPP8ftTn76vaG7TCYswrB
         wu1Q==
X-Gm-Message-State: ABy/qLY67cRsFWJWfjRRyqwRvPe6d9vPf3DQ0jaau4m+Qlvz1CKRK9JX
        cB3Xdvh1y9MBxui1nFIpov/EnGDhZDM=
X-Google-Smtp-Source: APBJJlEJvrrWRjivtDC74iqDsCm2vZh8M1I8sDQsSCZ36ZOU/f320fThaFIiZMrMrmh63IpPEUK2ew==
X-Received: by 2002:a17:906:8a70:b0:99b:ce6d:fc90 with SMTP id hy16-20020a1709068a7000b0099bce6dfc90mr1982060ejc.2.1690530264115;
        Fri, 28 Jul 2023 00:44:24 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q24-20020a17090622d800b00997e00e78e6sm1704147eja.112.2023.07.28.00.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:44:23 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: pxa: Don't reimplement of_device_get_match_data()
Date:   Fri, 28 Jul 2023 09:44:17 +0200
Message-ID: <169053024118.3514419.7335400972528269945.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718150657.1728166-1-u.kleine-koenig@pengutronix.de>
References: <20230718150657.1728166-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Tue, 18 Jul 2023 17:06:57 +0200, Uwe Kleine-König wrote:
> Apart from the return type pxa_pwm_get_id_dt() reimplements
> of_device_get_match_data(). Drop the former and replace the call to it
> by the latter.
> 
> 

Applied, thanks!

[1/1] pwm: pxa: Don't reimplement of_device_get_match_data()
      commit: 63808bbb3e226b0160f61723614e612fbf51541c

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
