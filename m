Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4DD85F12
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2019 11:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfHHJzz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Aug 2019 05:55:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36283 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731278AbfHHJzz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 05:55:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so9044571ljj.3
        for <linux-pwm@vger.kernel.org>; Thu, 08 Aug 2019 02:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oDN0rGjGfc55O/5uQ01ERUI7cndh16/GKyAUPFzsNBE=;
        b=QbDLnC9h4d3ToHUAty+Zr9ImspSeY5IL36mAYD2g3oT/4MVJsDpXoeLDZyn9jsCDyw
         OVF57q28R8kjecdfpvJnmSyFGgOey56sPAcz8kuuWrxgOVMFzfnKhtHzbnxm7QvRrr/z
         eQIJNQpIDhWPKdc/qOtERa6aeBnSWyHYilw6tIK+Fm4Y1DbwD3tHogXjhbN2Zwyv67kK
         joOyBPyUEdF14C36Uq8/V0/y5WpuxY61qQf+pWRC+8sihMlEmWT4PGTTXIY3F+XTLCso
         AW/04Mu/aOFMsE34NRKd8OAKCt5QC9py3BVrKHvHQYRCmcd1WvIbTySkbj/RD/GcueqD
         GQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDN0rGjGfc55O/5uQ01ERUI7cndh16/GKyAUPFzsNBE=;
        b=W2Cwz0lsxDZEF8Rlj4IhY5w4ypqHhOXQs2fEGSqbRU/V3orLv5uB2lRHVG49J+LYwX
         DLgPUx+aHd9bnjr0jjfFAQF8HpHInoVRJ3oy2fNC2sr45pw5SVYzapQOAEA/8sXunMPf
         0StiISTop6Ogrot7+MAjB73ua7OrBsm9Uwp8B7EZOm4LkffIbr1npILoiX4y7LLr5ntq
         dtNwme99S5HVy0fd3YNviS5Igl3abTdiQcN/TfAxHuL0o6tp7dfNqbzQzd2WfYfvpQRG
         2FTC9bXjoqRwqKxHmiC8uhjyMb0XH3LdJ/ApQ77wJIJVG5icg7IA0wHKORRW78S9qd2E
         gIfg==
X-Gm-Message-State: APjAAAXZ/UqT4bD0FIOd3xQOKw/OhRxOCjFWIoXrBuadt/S5Jt3SZ6HN
        xjqnz+xBF+jdEFN8ullEOhOVhQ==
X-Google-Smtp-Source: APXvYqx8a18LmOP1nJo/tE60vMtHdZ6dS1T/SaZhLRJiJwecapVQuDKcX9h7L6697ygui55hZPLrWA==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr7759677ljj.170.1565258153172;
        Thu, 08 Aug 2019 02:55:53 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8c7:ada9:25b2:24d8:3973:eb87? ([2a00:1fa0:8c7:ada9:25b2:24d8:3973:eb87])
        by smtp.gmail.com with ESMTPSA id t137sm16789638lff.78.2019.08.08.02.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 02:55:52 -0700 (PDT)
Subject: Re: [PATCH v2] pwm: rcar: remove a redundant condition in
 rcar_pwm_apply()
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <1565246333-2185-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b528827c-1744-901e-b795-ddd1aaf828d3@cogentembedded.com>
Date:   Thu, 8 Aug 2019 12:55:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565246333-2185-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello!

On 08.08.2019 9:38, Yoshihiro Shimoda wrote:

> Since the rcar_pwm_apply() has already check whehter state->enabled

    Checked?

> is not set or not, this patch removes a redundant condition.

    Is set or not?

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
[...]

MBR, Sergei
