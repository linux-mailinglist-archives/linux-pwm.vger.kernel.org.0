Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF22754C1
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Sep 2020 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIWJsK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Sep 2020 05:48:10 -0400
Received: from sonic305-20.consmr.mail.ne1.yahoo.com ([66.163.185.146]:37024
        "EHLO sonic305-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgIWJsK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Sep 2020 05:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600854489; bh=zXaFIo8mjTpXao4VNtylOhTc/LqLzQin3ncX1bFuSgM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dIOfYu/i3BwIb4SbodcQMad4VNKB4SGJsBtYlJs+xVpuJV6VrahQWWx0JeYay2iT93GLug2VmGD+GNUiQlL+Eaqc/w9vfnhsVnHKe8BtVXmLcKnhZ3GZFvVE6wipTagaZyeGVy+a6y8i0a13RZZ0px7k+S3ANcdUT7pUOclgV2apeZ8vP+nFS24K84KYblEzqkwHVjgc+YSo8PNJsEYp3GiG3ybOYLwTp7i+gyuaiSVAdNViO3s6+Oxy2OsvP9g78uHOIBSF5xK1LfFQlRWJJJ8dk9PsrQ/8ldapptS0A6CemoONGxjOrAf+cdnA8x2LKZkQdqgv2tBYMbfHxNKAcg==
X-YMail-OSG: vJ8ZfGMVM1kQLi0no9QWBdNtCKfsAFal72qIv6msmOAKDaLDpLkvbU4XfXM1v44
 rBlXladZNeZXgWfZSqhqUkZ9hAO9WKxhuRhM3vXi73VBKi0lAeJMfAbjE5EHnDrqQEajr6TTSOxQ
 QBdbiZsjAWAf8MMYA6ZsVvxITRhf6ixMnqyfwvImHto9oefxSYoFp9iHBDnWvv90H.7O97QOmHqn
 si0hkas4lwKglwMsPZYKyCk6PJTBUv1xDC9NeRScyyZdEz1vojdAbAeFYHAamtYdRkIMTZ92_AqC
 PjRCtmRsR22lRuWb2o1_ZwubAVM.3cR7EF0jiaT5iN0vk3HfOmViazevNuNNL.JxxzXbnxKzisQ3
 41MEF.fROTYreqBy8vPRRMPIbUYW2tsahTnC4oiqtWjMMYfRT3u9vEHPYViCvMvG5CUuNUVIJ_W0
 wuvlyTni2Ycqd.DIW1Tcl21C7L77OsUChrTjrdbOail81LOKyM7va7epTiSR5wbC4npi5CDgPB_4
 aUBpcCZFr.fNKBxPgPjXpB5BcoHMw00yoytBz6ecFzF9Lx2yun35ez7frTaDbdAgkB54ZmLSJpVC
 BwHX8nXIXE5xUF_z3R18ra9qRECHairU5eSRCDI1AGtKLMfLi2NyxRA1bGAip9tz83haJ4WXrl8_
 r1MwCbceEQi1fQ9z_bntrjrfDjbOlvVSWWV0Gwiiep1olDoMfSg.XWe1Cb2IElXCKrodZFMbSVfv
 cERnmyOYHVhQ5FgJ3eyFwOCxjsZB4r8T3goru86D89sULaKTjWS99lRH.0BGP2yYv0cEqMzofwqj
 qO4zjfx73l6fRyeW9nAxPAdiYCoQrlEK0IfkIIyJzrsAgRSn.N2Vc4snREP1fHFtHyvvjAXt.qtY
 O0HT8.FrF6cKDZIaqwt0oijMfEZNPszcdzGOp4ueD5_F.31fw0uFUKj4nNK5NFNnTvoDpJLH2j7Q
 y0SX3UnsH0g8KERjGSHcesjYOdpOFh4EI_RMgRVxJyse6OjI_UEIR9z7dk5wwDHpm4o7lP1Ei8zQ
 s_QDFo.Sx5WpXRa_tzuuCZN0CyUjcsvfPONplxEBqqkS3.jWF.9BQNfEJuLgbTWzfrAdJ.aeV7GN
 _a75v8OvyGAj7aRi6Jnah1aI7Dp7k7UCpx4kceBoSP7pnBzULW4TMJROo760VNSUXwQCdUya_yjJ
 QNV5B2plqP1q0nrj54S8Z2FXJ.cfy3wyUVMQ.d7HhF4po17hgzxd4XfsUS__Wnri9YNeA824L72J
 vkQmXTHqgvic3p8ONo9kv7JPTddpzjLzEXJ0CADQx6eYF3O0VkJ2P8PZyAShgVGCPlLJY_F9Wrrw
 vwlIlJeLgb2HA9quIpSAjYUiatPKzcx_v4Tx2tWQtVGyqw.tcdt0yqaFvz9DwGJ4kqX1RXznM3ME
 m3zau9zUSSh7o53_DHP93PqNyQLmBFpk4cLvu1OnLGtGpC4qA0Jne9sY7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Sep 2020 09:48:09 +0000
Date:   Wed, 23 Sep 2020 09:48:05 +0000 (UTC)
From:   Kuban Manfi <nolanbraten4@gmail.com>
Reply-To: fadiansi55@gmail.com
Message-ID: <1672774242.142838.1600854485061@mail.yahoo.com>
Subject: VERY CONFIDENTIAL.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1672774242.142838.1600854485061.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



Compliment of the season,

My names are Mr. Kuban Manfi, i work a department manager in one of the reputable banks here in Africa.

I have a lucrative and profitable business which i would like to introduce to you. Please this is very confidential and if you are interested kindly get back to me for more details.

Thanks
Mr.Kuban Manfi
