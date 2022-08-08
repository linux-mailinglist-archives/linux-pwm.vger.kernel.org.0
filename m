Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037B958C4AA
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Aug 2022 10:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbiHHIHX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Aug 2022 04:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbiHHIGs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Aug 2022 04:06:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60AA13E94
        for <linux-pwm@vger.kernel.org>; Mon,  8 Aug 2022 01:06:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n4so8184005wrp.10
        for <linux-pwm@vger.kernel.org>; Mon, 08 Aug 2022 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=E/imfulZV4VdZtp3bNUda6W+x0wKRPhCeOXH1Jx2YFs=;
        b=I9Dy394DwMUv0jhqSz9hSemGy+gBaP30VkiwCE7ceUSC72qxAn67nIyIUiGEqo6/fv
         y0uWxk9C/m8Uq4tGhu7rCyTJ54S+WIK5QTUZtO1Zg8r8pxPeL6qKi1Fnms4bKZWCowuT
         2dNKWWjGq/o3j4t32mnvULsIsRie6LDQqs6wKMOGLnzM10N5gBsMUFr1bcLltzf4SNLb
         UlkNDxs5OafuxS5hqNmeUD7+nWVQ+uTIVBqgxPzqF5cJaGFkfiMEgMph1BihcAAWbstu
         O4Vd68eOMKG14aJqosUHsh3XE/UrFakxELbHAchZ+asFXwPtmnK83K8PvFjQkc21ZAxg
         4FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=E/imfulZV4VdZtp3bNUda6W+x0wKRPhCeOXH1Jx2YFs=;
        b=Erj0ok/MOmI0fmyW1Bim4UGEfXfu4d0lBUMPGqjUhPsHJAn/ZgJbjvB3LPkX7qtRgv
         WGpyxdAZhG77eWnGM1GQBSYVUC/tBM2P9kc1SL8HS9HvTAplcKrFhAZN08cDbVC/pIll
         Pvbyyk6KJbNnNwDdLIVJHfox2z/jkg7CYvro0QBvuXKlahFy5MAUBTb46lfsKTmIXySf
         iwgxFho52TV0M6gRPtqXyE7QKcf14g1na9Qho6E51WlVLjCe2XU3UI7S5tfDuxuEB/Z6
         EqUHsoftlxp5LHzHcmUbOAX/j2lQQ0GqLSBDc/M3E7OAgmdnsRDCA0Ha/zL3kBQ/GoZ/
         CnvA==
X-Gm-Message-State: ACgBeo1ZcYmfe3G6fY0Y1Mto9cHDI5OndmsD6Mne4NsqwswPLuayRsTM
        xwV074zlx42uheEipZAYCRxDerYXaoDTqQ==
X-Google-Smtp-Source: AA6agR5T/J2nGgk3gPquXIqNudB0uPwmFf3dtFSu0n8k3nmvHueFCOFrc+G44I7JHZaFuunNHWTrsg==
X-Received: by 2002:a5d:52cb:0:b0:21a:3cc5:f5f4 with SMTP id r11-20020a5d52cb000000b0021a3cc5f5f4mr10890723wrv.367.1659946005328;
        Mon, 08 Aug 2022 01:06:45 -0700 (PDT)
Received: from [10.35.5.6] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id d15-20020adfe84f000000b00220628ef654sm10505163wrn.24.2022.08.08.01.06.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 01:06:44 -0700 (PDT)
Message-ID: <b78e07bc-70ca-6ddd-5b80-2f6865d242ec@sifive.com>
Date:   Mon, 8 Aug 2022 09:06:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: DesignWare PWM support for device-tree probing
Content-Language: en-GB
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Lee Jones <lee@kernel.org>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
 <YvDCwOPLoSdxorhZ@google.com> <YvDDHUJdBRSRjbRh@google.com>
From:   Ben Dooks <ben.dooks@sifive.com>
In-Reply-To: <YvDDHUJdBRSRjbRh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/08/2022 09:02, Lee Jones wrote:
> On Mon, 08 Aug 2022, Lee Jones wrote:
> 
>> On Fri, 05 Aug 2022, Ben Dooks wrote:
>>
>>> This series is tidying up and adding device-tree support for the
>>> DesignWare DW-APB-timers block.
>>>
>>> Changes:
>>>
>>> v3:
>>> - change the compatible name
>>> - squash down pwm count patch
>>> - fixup patch naming
>>>
>>> v2:
>>> - fix #pwm-cells count to be 3
>>> - fix indetation
>>> - merge the two clock patches
>>> - add HAS_IOMEM as a config dependency
>>
>> Can you use the front-cover option provided by Git please Ben?
> 
> git format-patch --cover-letter ...

I thought git-send-email --compose did that.
