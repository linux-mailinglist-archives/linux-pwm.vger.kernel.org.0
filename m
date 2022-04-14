Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33755500945
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Apr 2022 11:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiDNJJS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 14 Apr 2022 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbiDNJJR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Apr 2022 05:09:17 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7942B6C49E;
        Thu, 14 Apr 2022 02:06:53 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id kl29so3557691qvb.2;
        Thu, 14 Apr 2022 02:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KEDN+O6ECzo0zTmWbSoDphmExajceJORswAVXwDzLJY=;
        b=Ct6R1jmTEXeUDa1vz3rPiDmLSkvZFMP4qN2ywWeLt4CAf+CvA2ZBcVFYfCZLl7RHK6
         f96bCp5MS+c3zKR7dvq+i03CLpJLrHu4wP5RHt2QMuRr/xhm9eoWY/bb4BoMBmsP21lS
         SG5LO+F3vJQd8EE9euqv99ZyA0p7s9QASUg2knuhvyBpR56lvGH2HAPckrpOjxt+wuxo
         NNK+s/3WclSt3jbFnGDkMdjN97ev7PdZtfIHp5mIZ6igEooX9KY4DiE0Z8zkbiBTRyVn
         qkcM6PQkfzm2BVTOPdc6OYlLxGpC2L/5Hr6pBGUXR9TD0Wq6LTxyHBOxzK8ELPbh2MEr
         hN/A==
X-Gm-Message-State: AOAM533zwhpSHc2P6AWvdhqoDR3TDON59K52jZVfLyKdKJgptzlOzYd1
        ZEL5eBjPp67+Ld+GQpkPh+6ShynUc78FFQ==
X-Google-Smtp-Source: ABdhPJx+SNMj/XJWhpWkLH3cVBbpo+lpTffvQaonRw+Py2OPp1sDL91dq8YlYREZ1e5c7K6MaTLyWQ==
X-Received: by 2002:a0c:8151:0:b0:42c:2329:91a0 with SMTP id 75-20020a0c8151000000b0042c232991a0mr2386889qvc.107.1649927212570;
        Thu, 14 Apr 2022 02:06:52 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id v7-20020a379307000000b0069c0a2afc55sm699645qkd.123.2022.04.14.02.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 02:06:52 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id t67so8306276ybi.2;
        Thu, 14 Apr 2022 02:06:52 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr1020261ybq.342.1649927211912; Thu, 14
 Apr 2022 02:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 11:06:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdi3TAv7+UUZ3OETe946SXfHj_JPaiP8tFG=u9OzKaXw@mail.gmail.com>
Message-ID: <CAMuHMdXdi3TAv7+UUZ3OETe946SXfHj_JPaiP8tFG=u9OzKaXw@mail.gmail.com>
Subject: Re: [PATCH 1/6] pwm: renesas-tpu: Make use of dev_err_probe()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Apr 13, 2022 at 10:51 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The added benefit is that the error code is mentioned in the error message
> and its usage is a bit more compact than open coding it. This also
> improves behaviour in case devm_clk_get() returns -EPROBE_DEFER.
>
> While touching this code, consistenly start error messages with upper

consistently

> case.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
