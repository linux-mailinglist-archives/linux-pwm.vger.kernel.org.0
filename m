Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1044862736A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Nov 2022 00:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiKMXPj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Nov 2022 18:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiKMXPi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Nov 2022 18:15:38 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD239E0DB
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:15:36 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o7so8900735pjj.1
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ua2EXt1MeG/C5N+27MH51YtcjSku0w318rDZK7hPAE4=;
        b=haANtiG7uiMdray2yGMv3NsfGKgIDrmW/LdcR1IVF79JieO5WwzLHGAtiPhvmpHrGb
         ljZpUimQxfpND/B0dQr1qmNQB6gvug56zZWiI1KtTwhd9kpJTBUtRDlXxDrYN6mJwYdg
         Xf1ZjQl3iehLsTTgSO6MjX1fZ6B1JTgJJrO6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ua2EXt1MeG/C5N+27MH51YtcjSku0w318rDZK7hPAE4=;
        b=hvezGNjHBFNt1TfI/oOHv0wGNl07ljFvHA/wBzl/ebL53m+SsrSbnEdOoVF+zJ5CBo
         J0bcNjjIjgzJ0JA0ffT1pL2Kqkio/HUuXDeqUvVBU70sjt800Wx+x3FqWZrcq30xHh7d
         4O5z6ayuSLh7/DfmundtvhJ0T+OFPP8qnuHnqjfShEGTeGqFytUNop43UpPBT9QCXhAW
         YxBm4flIyk6jzt2fvGXSH6qX+cPZ1mBq7UTH1mIMrJTwFXJ/1SJQLQdRm92zPeK7pUjD
         Z1OqiBy/iZjXDkRRJNwUusXZcDQ6NcEtGSuXUQtBPt/bVyoiCMi+fxMk9sIsiQwAvRGb
         d0Uw==
X-Gm-Message-State: ANoB5pkOFsCq73gXD1JIzaVtUp145cyowCVbYxbgq/WPyECG68CHTHsC
        PGkn4aQvZ0wKU93MAPCypDRzNA==
X-Google-Smtp-Source: AA0mqf6sHWjBC8+vEobBu++bONNsaC1f/LVWAhS7QWbniD0poqh903OGTioJqzxT6svrbU6AGTebdQ==
X-Received: by 2002:a17:902:ab14:b0:186:7db1:d2a4 with SMTP id ik20-20020a170902ab1400b001867db1d2a4mr11140647plb.84.1668381336272;
        Sun, 13 Nov 2022 15:15:36 -0800 (PST)
Received: from [192.168.1.33] ([192.183.212.197])
        by smtp.googlemail.com with ESMTPSA id t10-20020a63224a000000b00460fbe0d75esm4717469pgm.31.2022.11.13.15.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 15:15:35 -0800 (PST)
Message-ID: <909aa8a6-c5f9-4547-e02c-9e23254917ca@schmorgal.com>
Date:   Sun, 13 Nov 2022 15:15:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
References: <20221003015546.202308-1-doug@schmorgal.com>
 <20221003015546.202308-3-doug@schmorgal.com>
 <20221019073417.cck7lrfnzobj3hbk@pengutronix.de>
From:   Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH v2 2/5] pwm: pxa: Set duty cycle to 0 when disabling PWM
In-Reply-To: <20221019073417.cck7lrfnzobj3hbk@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 10/19/2022 12:34 AM, Uwe Kleine-König wrote:
> On Sun, Oct 02, 2022 at 06:55:43PM -0700, Doug Brown wrote:
>> When disabling PWM, the duty cycle needs to be set to 0. This prevents
>> the previous duty cycle from showing up momentarily when the clock is
>> re-enabled next time, and also prevents the output pin from being stuck
>> high when the clock is disabled.
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

It appears I messed up when writing the commit message for this patch,
because I did some more testing today with raw register writes and the
output pin definitely doesn't get stuck high when I disable the clock --
no matter where we are in the PWM cycle. Either way, it still makes
sense to set the duty cycle to 0 first. Just wanted you to know that I'm
not changing the patch at all -- just the commit message -- on v3, so
I'm not carrying over your Reviewed-by tag on v3 of this patch. Sorry
about that!

Doug
